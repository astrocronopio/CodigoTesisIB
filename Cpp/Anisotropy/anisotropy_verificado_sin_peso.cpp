#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>


using namespace std;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

double T_S	= 23.9344696,  T_D 	= 24.0;


double right_ascension(unsigned long utc, unsigned long iutcref)
{
	double raz = double(utc-iutcref)/239.345 + 31.4971;
	raz = raz - floor(raz/360.)*360.;
	if(raz<0.0) raz = raz + 360;
	return raz;
}


void rayleigh( float *a , float *b, float *sumaN,
			   float *freq, unsigned long utci, unsigned long utcf,
			   	const char* in_file)
{
	unsigned long utc0 = 1072915200,   iutcref = 1104537600  ; //1/1/2005 00:00:00;
	string line;

	int utc,t5, iw;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;

	double fas = *freq/366.2559; //Ver comentario en el otro código

	double raz, arg, hrs, peso;

	ifstream myfile (in_file);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 

			if(utcf < utc) break;
			if(utc < utci || Theta > 80) continue;

			hrs= (float(utc - utc0)/3600.0 + 31.4971*T_D/360.0)*fas;

			peso =1.0;
			
			*sumaN+=peso;
			raz = right_ascension(utc, iutcref);

			arg = 2.0*pi*hrs/T_D + (Ra-raz)*d2r;
			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	
	}
	myfile.close();
}

float ray_multifreq( int nf, bool flag, const char* in_file, const char* out_file){

	unsigned long utci =  flag ? 1372680068 :  1072959037;
	unsigned long utcf =  1577836799 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	ofstream myfile (out_file);

	for (int i = 0; i < nf; ++i)
	{
		float freq = 364 + i*3.0/nf;

		cout << " Iteration "<< i +1 <<" of " << nf<< endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); //VER COMENTARIO EN EL OTRO CODIGO

     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< endl;
	}
}

int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* in_file = argv[1];
	const char* out_file= argv[2];

	ray_multifreq(250, true, in_file, out_file);
	
	return 0;
}
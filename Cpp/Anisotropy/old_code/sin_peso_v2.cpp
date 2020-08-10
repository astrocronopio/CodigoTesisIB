#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <stdexcept>

//using namespace std;

//Global Parameters
float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

//The output of this function is the right ascension of the observatory cenit
double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);
	double raz = aux/239.345 + 31.4971;
	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

const int interval =288;

void rayleigh( float *a , float *b, float *sumaN,
			   float *freq, unsigned long utci, unsigned long utcf,
			   	const char* in_file)
{
	unsigned long utc0 = 1072915200,   iutcref = 1104537600  ; //1/1/2005 00:00:00;
	std::string line;

	int utc,t5, iw;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr, aux;

	double fas = *freq/365.25; //Ver comentario en el otro código

	double raz, arg, hrs, peso;

	std::ifstream myfile (in_file);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			std::stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 

			if(utcf < utc) break;
			if(utc < utci || Theta > 80) continue;
			
			hrs=((double)(utc-utc0)/3600.+ 21.+5)*fas; // hora local
			//hrs= right_ascension(utc)*fas*24./360.; 	   // hora siderea

			aux=hrs*interval/24.0;
			peso =1.0;		
			*sumaN+=peso;
			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;
			//arg = (Ra)*d2r;
	
			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	
	}
	myfile.close();
}

float ray_multifreq( int nf, const char* in_file, const char* out_file,unsigned long utci, unsigned long utcf){

	//unsigned long utci =  1104537600; //1372699409 ;
	//unsigned long utcf =  1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	for (int i = 0; i < nf; ++i)
	{
		float freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
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
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}

int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)

	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;
	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	
	ray_multifreq(500,  in_file, out_file, utci, utcf);
	
	return 0;
}
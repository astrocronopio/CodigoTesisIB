#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>

using namespace std;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03;
float P0 	= 862.0;
float rho0	= 1.06;

float right_ascension(unsigned long utc, unsigned long iutcref)
{
	float raz = float(utc-iutcref)/239.345 + 31.4971;
	raz = raz - int(raz/360.)*360.;
	if(raz<0.0) raz = raz + 360;
	return raz;
}

void weather_correction(float theta, float * aP, float* arho, float *brho)
{	
	float sin2 = sin(theta*d2r)*sin(theta*d2r);

	*aP=0.0009-0.011*sin2+0.011*sin2*sin2;
	*arho=-1.15+0.6*sin2+0.9*sin2*sin2;
	*brho=-0.42+0.5*sin2-0.001*sin2*sin2;

	if(*arho >0.) *arho = 0.;
	if(*brho >0.) *brho = 0.;
}

float efficiency(float theta, float weather, float energy)
{	
	float sin2 = sin(theta*d2r)*sin(theta*d2r);

	float power = 3.8*(sin2)*sin2 - 1.2*sin2 + 3.3;
    float E05 = 4.3*(sin2)*sin2*sin2 - 2.2*(sin2)*sin2 - 0.2*sin2 + 0.88 ;

    float eff = 1 + Bb*weather*power*powf(E05, power)/(powf(energy, power) + powf(E05, power));

    return eff;
}


void rayleigh( float *a , float *b, float *sumaN, float *freq, unsigned long utci, unsigned long utcf)
{
	float phitilt = -30.0*d2r;
	unsigned long utc0 = 1072915200;
	unsigned long iutcref = 1104537600;   //1/1/2005 00:00:00;
	string line;

	int utc,t5, iw;
	float Phi,Theta,Ra,x1,x3,energy, p, r, rav, AugId,Dec,energy_raw, energy_cor,ftr;
	float arho, aP, brho;

	float fas = *freq/365.25;

	ifstream myfile ("../../Herald/Central/Modified/Energy_above_1EeV/Herald_8EeV.dat");
	//ifstream myfile ("../Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat");

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>x1>>x3>>energy>>t5; //>> p>> r>> rav>> iw ;
			//liness>> AugId >> Dec>> Ra>> energy_raw >> energy_cor >> utc >> Theta>>Phi>>t5>>ftr;
			//energy=energy_raw;
			if(utc < utci || utc > utcf || Theta > 80 || energy<=8.0) continue;
		
			//weather_correction(Theta, &aP, &arho, &brho);
			//float weather = aP*(p-P0)+arho*(rav-rho0)+brho*(r-rav);
			//float eff= efficiency(Theta,weather, energy);

			float  hrs= (float(utc - utc0)/3600.0 + 31.4971*24.0/360.0)*fas;
			//int nh = (hrs%24);

			//float exposure= exposure_weight(utci, utcf, nh); 

			float peso =1.0;
			*sumaN+=peso;
			float raz = right_ascension(utc, utc0);

			float arg = 2.0*pi*hrs/24.0 + (Ra-raz)*d2r;
			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	
	//cout << *a<< endl;
	}
	myfile.close();


}

float ray_multifreq(){
	int nf=500;
	unsigned long utci = 1072915200;
	unsigned long utcf = 1544933508;

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	ofstream myfile ("ICRC2018_data_file_Eraw.txt");

	for (int i = 0; i < nf; ++i)
	{
		float freq = 364.0 + i*3.0/nf;

		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &freq, utci, utcf);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN);

     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< endl;
	}
}


float exposure_weight(unsigned long utci, unsigned long utcf)
{
	

	return 1;
}


int main(int argc, char const *argv[])
{	
	ray_multifreq();
	
	return 0;
}
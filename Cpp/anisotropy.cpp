#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <math.h>



using namespace std;

float pi = M_PI;

float d2r = pi/180.0;

float Bb= 1.03;

float rho0= 1.06

float right_ascension(unsigned long utc, unsigned long iutcref)
{
	float raz = float(utc-iutcref)/239.345 + 31.4971;
	raz = raz - int(raz/360.)*360.;
	if(raz<0.0) raz = raz + 360;
	return raz;
}


float  efficiency(float theta, float energy)
{
	float sin2 = sin(theta*d2r)*sin(theta*d2r);

	float aP=0.0009-0.011*sin2+0.011*sin2*sin2;
	float arho=-1.15+0.6*sin2+0.9*sin2*sin2;
	float brho=-0.42+0.5*sin2-0.001*sin2*sin2;

	if(arho >0.) arho = 0.;
	if(brho >0.) brho = 0.;

	float pow = 3.8*sin2*sin2 - 1.2*sin2 + 3.3;
    float E05 = 4.3*sin2*sin2*sin2 - 2.2*(sin2)*sin2 - 0.2*sin2 + 0.88;

    weather= aP*(p-P0)+arho*(rav-rho0)+brho*(r-rav);

    eff=1+Bb*weather*pow*E05**pow/(En**pow+E05**pow)
}


void rayleigh( float *a , float *b, float *sumaN, float *freq, unsigned long utci, unsigned long utcf)
{
	

	float phitilt = -30.*d2r;
	unsigned long utc0 = 1072915200;
	unsigned long iutcref = 1104537600;   //1/1/2005 00:00:00;
	string line;

	int utc,t5, iw;
	float Phi,Theta,Ra,x1,x3,energy, p, r, rav;
	float arho, aP, brho;

	int iscor = 1;

	float fas = *freq;

	int nval=0;
	*a=0.0; *b=0.0; *sumaN=0.0;

	ifstream myfile ("../../Trash/Herald_8EeV.dat");

	myfile.clear();


	if(myfile.is_open())
	{
	
		while (!myfile.eof() ){			
			getline(myfile,line);			
			stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>x1>>x3>>energy>>t5>> p>> r>> rav>> iw ;
			
			if(utc < utci || utc> utcf || Theta >80) continue;
			
			weather_correction(Theta, &aP, &arho, &brho);



			}
	
	}


}

float ray_multifreq(){
	int nf=1;
	unsigned long utci = 1072915200;
	unsigned long utcf = 1544933508;

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	ofstream myfile ("first_try.txt");

	for (int i = 0; i < nf; ++i)
	{
		float freq = 364.0 + i*3.0/nf;

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
     	r99r=sqrt(4.*log(100.)/sumaN);

     	myfile <<freq<< a << b << sigma << rtilde << prtilde << pha/d2r << sgmra/d2r << r99r << endl;
	}
}

int main(int argc, char const *argv[])
{	
	ray_multifreq();
	
	return 0;
}
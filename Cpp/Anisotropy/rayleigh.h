#if !defined(RAY)
#define RAY

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

double pi 	= M_PI;
double d2r 	= pi/180.0;
double Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;
const int interval= 288;

double energy_threshold=0;

typedef void (*g)(double * , double *, double *, double , 
				long long , long long , const char* );


double right_ascension(long long utc)
{	
	long long iutcref = 1104537600;
	double raz = (double)(utc-iutcref)/239.345 + 31.4971;

	raz = raz - int(raz/360.)*360.0;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

int method_weight_solar(int utc, double fas, int interval){
	unsigned iutcref = 1072915200;
	double x1=((long double)(utc-iutcref)/3600. +  2.099806667)*fas; // hora local 
	int	aux=  int(fmod(x1*interval/24.0, interval));
				
	return aux;
}


void ray_multifreq( int nf, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g rayleigh ){
	
	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	double freq=0.0;

	for (int i = 0; i < nf; ++i)
	{
		freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		std::cout<<rtilde<<std::endl;
     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}



void ray_given_freq( double freq, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g rayleigh){
	

	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	int Iterations=1;

	for (int i = 0; i < Iterations; ++i)
	{
		double freq1 = freq + i*0.01;
		std::cout << " Iteration "<< i +1 <<" of " <<Iterations<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		std::cout<<rtilde<<std::endl;
     	std::cout <<  "Frecuencia: "<< freq1 		<< "\t Amplitud: " << rtilde << "\t";
     	std::cout <<  "Probabilidad: "<<prtilde 	<< "\t Fase: " << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}



#endif // RAY

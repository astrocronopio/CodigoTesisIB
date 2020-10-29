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

typedef void (*g)(double * , double *  , double *, 
				   double* , double *  , double	 ,
				 long long , long long , const char* );


double right_ascension(long long utc)
{	
	long long iutcref = 1104537600;
	double raz = (double)(utc-iutcref)/239.345 + 31.4971;

	raz = raz - int(raz/360.)*360.0;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

void amplitud_phase_r99(double a,				double b, double sumaN,
						double average_cos_dec, double average_sin_theta,
						double *pha, double *rtilde, double * prtilde,
						double *sgmra, double *sigma, double * r99r, double* d_perp){
		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	*pha= atan(b/a);

     	if (a < 0) *pha= *pha+pi;
     	if (a>0 && b< 0) *pha = *pha +2.*pi;
		
		*pha+=  0.5*pi;
		*pha = *pha>2*pi ? *pha-2*pi: *pha;
		//*pha = fmod(*pha+ 0.5*pi , 2*pi);

     	*rtilde= sqrt(a*a + b*b);
		*d_perp = 0.5*pi*(*rtilde)/average_sin_theta;

     	*prtilde = exp(-sumaN*(*rtilde)*(*rtilde)/4.0);
     	*sgmra = sqrt(2./sumaN)/(*rtilde);
     	
		double factor = 0.5*pi*average_cos_dec/average_sin_theta;
		*rtilde = *rtilde*factor;
		*sigma = sqrt(2./sumaN)*factor;

		*r99r  = sqrt(4.*log(100.)/sumaN)*factor; 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										        // QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
}

void ew_multifreq( 	int nf, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method ){
	
	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double d_perp, factor;
	double sigma=0.0, sgmra=0.0;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile (out_file);

	double freq=0.0;

	// average_over_cenit( utci, utcf, in_file, 
	// 					&average_sin_theta, 
	// 					&average_cos_dec);

	for (int i = 0; i < nf; ++i)
	{
		freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;
		average_cos_dec=0.0; 
		average_sin_theta=0.0;

		east_west_method(&a, &b, &sumaN, 
						 &average_sin_theta, 
						 &average_cos_dec, freq, utci, utcf, in_file);

		amplitud_phase_r99(a, b, sumaN, average_sin_theta, average_cos_dec, 
						  &pha, &rtilde,&prtilde,&sgmra,&sigma, &r99r, &d_perp);

		std::cout<<a<<std::endl;
		std::cout<<rtilde<<std::endl;

     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< d_perp<< std::endl;
	}
}



void ew_given_freq( double freq, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method){
	

	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double sigma=0.0, sgmra=0.0;
	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile ("throw.dat");

	int Iterations=1;

	for (int i = 0; i < Iterations; ++i)
	{
		double freq1 = freq + i*0.01;
		std::cout << " Iteration "<< i +1 <<" of " <<Iterations<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		east_west_method(&a, &b, &sumaN, 
						 &average_sin_theta, 
						 &average_cos_dec, freq, utci, utcf, in_file);
		
		amplitud_phase_r99(a, b, sumaN, average_sin_theta, average_cos_dec, 
						  &pha, &rtilde,&prtilde,&sgmra,&sigma, &r99r, &d_perp);
		
		std::cout<<rtilde<<std::endl;
     	std::cout <<  "Frecuencia: "<< freq1 		<< "\t Amplitud: " << rtilde << "\t";
     	std::cout <<  "Probabilidad: "<<prtilde 	<< "\t Fase: " << pha/d2r << "+/-"<< sgmra/d2r << "\t r99:"<< r99r << "\t"<< std::endl;
	}
}



#endif // RAY

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

typedef void (*g)(double * , double *  , double *, double *, 
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


void ew_given_freq( double freq, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method){
	

	double a =0.0  , b=0.0, sumaN=0.0, mean_energy=0.0 ;
	double rtilde,pha,prtilde,r99r, d99;
	double sigma=0.0, sgmra=0.0;
	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile ("throw.dat");

	int Iterations=1;

	//for (int i = 0; i < Iterations; ++i)
	{
		//double freq1 = freq + i*0.01;
		//std::cout << " Iteration "<< i +1 <<" of " <<Iterations<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		east_west_method(&a, &b, &sumaN, &mean_energy,  
						 &average_sin_theta, 
						 &average_cos_dec, 
						 freq, utci, utcf, in_file);
		
		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
		average_cos_dec/=sumaN;
		average_sin_theta/=sumaN;
		
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;
		
		pha = fmod(pha+ 0.5*pi, 2*pi);
		if (pha>pi && pha<2*pi)
			pha=pha -2*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);
     	sgmra = sqrt(2./sumaN)/(rtilde);
     	
		double factor = 0.5*pi*average_cos_dec/average_sin_theta;
		rtilde = rtilde*factor;
		d_perp = (rtilde)/average_cos_dec;
		sigma = sqrt(2./sumaN)*factor;

		r99r  = sqrt(4.*log(100.)/sumaN)*factor; 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										        // QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		d99 = r99r/average_cos_dec;

		mean_energy=mean_energy/sumaN;

		std::cout.precision(8);
		std::cout <<"Eventos: "<<sumaN<<"\nEnergía media: "<< mean_energy <<std::endl;
     	std::cout << "\nFrecuencia: "<< freq << "\nAmplitud: " << rtilde<<std::endl;
		std::cout << "d_perp: "	<< d_perp<<"\n";
     	std::cout << "Probabilidad: "	<< prtilde 	;
		std::cout << "\nFase: "     	<< pha/d2r << "+/-"<< sgmra/d2r ;
		std::cout << "\nr99:"<< r99r << "\nd99: "<< d99 << std::endl;
	}
}



void ew_multifreq( int nf, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method){
	

	double a =0.0  , b=0.0, sumaN=0.0, mean_energy=0.0 ;
	double rtilde,pha,prtilde,r99r, d99;
	double sigma=0.0, sgmra=0.0;
	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile ("throw.dat");

	double freq=0.0;

	for (int i = 0; i < nf; ++i)
	{
		freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		east_west_method(&a, &b, &sumaN, &mean_energy,  
						 &average_sin_theta, 
						 &average_cos_dec, 
						 freq, utci, utcf, in_file);
		
		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
		average_cos_dec/=sumaN;
		average_sin_theta/=sumaN;
		
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;
		
		pha = fmod(pha+ 0.5*pi, 2*pi);
		if (pha>pi && pha<2*pi)
			pha=pha -2*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);
     	sgmra = sqrt(2./sumaN)/(rtilde);
     	
		double factor = 0.5*pi*average_cos_dec/average_sin_theta;
		rtilde = rtilde*factor;
		d_perp = (rtilde)/average_cos_dec;
		sigma = sqrt(2./sumaN)*factor;

		r99r  = sqrt(4.*log(100.)/sumaN)*factor; 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										        // QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		d99 = r99r/average_cos_dec;

		mean_energy=mean_energy/sumaN;
		
		std::cout<<rtilde<<std::endl;
     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}



#endif // RAY

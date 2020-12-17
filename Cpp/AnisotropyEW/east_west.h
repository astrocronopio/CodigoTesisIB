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
	float raz = (float)(utc-iutcref)/239.345 + 31.4971;

	raz = fmod(raz, 360.0); //raz - int(raz/360.)*360.0;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}


void ew_given_freq( double freq, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method){
	

	double a =0.0  , b=0.0, sumaN=0.0, mean_energy=0.0 ;
	double rtilde,phase,prtilde,r99r, d99;
	double sigma=0.0, sigma_phase=0.0, sigma_dperp=0.0;
	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile ("throw.dat");

	{
		a=0.0; b=0.0; sumaN=0.0;

		east_west_method(&a, &b, &sumaN, &mean_energy,  
						 &average_sin_theta, 
						 &average_cos_dec, 
						 freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
		average_cos_dec/=sumaN;
		average_sin_theta/=sumaN;
		
     	phase= atan(b/a);

     	if (a < 0) phase= phase+pi;
     	if (a>0 && b< 0) phase = phase +2.*pi;
		
		/*Limita a 2pi*/phase = fmod(phase+ 0.5*pi, 2*pi);

     	/*Amplitude EW*/rtilde 	= sqrt(a*a + b*b);
     	/*Probability*/	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);
		/*Ampl.factor*/	factor 	= 0.5*pi*average_cos_dec/average_sin_theta;
     	
		/*Error*/		sigma 		= sqrt(2./sumaN)*factor;
		/*Error phase*/ sigma_phase = sqrt(2./sumaN)/(rtilde);
		/*Error dperp*/ sigma_dperp = sqrt(2./sumaN)*0.5*pi/average_sin_theta;
     	
		/*Amplitude  */ rtilde  = rtilde*factor;
		/*Ampl. d_perp*/d_perp = (rtilde)/average_cos_dec;

		// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
        // QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		/*Amplitud r99*/r99r  = sqrt(4.*log(100.)/sumaN)*factor; 	
		
		/*Ampl. d99*/   d99 = r99r/(average_cos_dec*average_cos_dec);

		mean_energy=mean_energy/sumaN;

		std::cout.precision(8);

		std::cout <<"Eventos:\t"		<< sumaN		<< std::endl;
		std::cout <<"Energía media:\t"	<< mean_energy 	<< std::endl;
     	std::cout <<"Frecuencia:\t"		<< freq 		<< std::endl;
		std::cout <<"Amplitud:\t"		<< rtilde		<< "+/-" << sigma<<std::endl;
		std::cout <<"d_perp:\t"			<< d_perp		<< "+/-" << sigma_dperp<<"\n";
     	std::cout <<"Probabilidad:\t"	<< prtilde 		<< std::endl;
		std::cout <<"Fase:\t"			<< phase/d2r 	<< "+/-" << sigma_phase/d2r ;
		std::cout <<"r99:\t"			<< r99r 		<< std::endl;
		std::cout <<"d99:\t"			<< d99 			<< std::endl;
	}
}

void ew_multifreq( int nf, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g east_west_method){
	

	double a =0.0  , b=0.0, sumaN=0.0, mean_energy=0.0 ;
	double rtilde,phase,prtilde,r99r, d99;
	double sigma=0.0, sigma_phase=0.0;
	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile (out_file);

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
		
     	phase= atan(b/a);

     	if (a < 0) phase= phase+pi;
     	if (a>0 && b< 0) phase = phase +2.*pi;
		
		phase = fmod(phase+ 0.5*pi, 2*pi);
		if (phase>pi && phase<2*pi)
			phase=phase -2*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);
     	sigma_phase = sqrt(2./sumaN)/(rtilde);
     	
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
     	myfile << prtilde 	<< "\t" << phase/d2r << "\t"<< sigma_phase/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}


void error_rtilde(double rtilde, double sigma, double rtilde_plus, double rtilde_minus)
{
	
}



#endif // RAY

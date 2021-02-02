#if !defined(RAY)
#define RAY

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

#include "../AnisotropyEW/rtilde_bounds_v5.hpp"
#include "../AnisotropyEW/phase_bounds_v2.hpp"

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

int method_weight_solar(int utc, double fas, int interval)
{
	unsigned iutcref = 1072915200;
	double x1=((long double)(utc-iutcref)/3600. +  2.099806667)*fas; // hora local 
	int	aux=  int(fmod(x1*interval/24.0, interval));
				
	return aux;
}


void ray_multifreq( int nf, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g rayleigh ){
	

	double a =0.0  , b=0.0, sumaN=0.0,  mean_energy=0.0 ;
	double rtilde,phase,prtilde,r99r,  rUL, d99, dUL;
	double sigma=0.0, sigma_phase=0.0, sigma_dperp=0.0;

	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile (out_file);

	double freq=0.0;

	for (int i = 0; i < nf; ++i)
	{
		freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &mean_energy,  
						 &average_sin_theta, 
						 &average_cos_dec, 
						 freq, utci, utcf, in_file);
		/*Normalize given events*/
		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;

		average_cos_dec/=sumaN;
		average_sin_theta/=sumaN;
		mean_energy/=sumaN;

		/*Rayleigh Parameters*/
     	phase= atan(b/a);

     	if (a < 0) phase= phase+pi;
     	if (a>0 && b< 0) phase = phase +2.*pi;	

		/*Amplitude*/	rtilde 	= sqrt(a*a + b*b);
     	/*Probability*/	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);

     	/*Error*/		sigma = sqrt(2./sumaN);
		/*Error phase*/ sigma_dperp = sigma/average_cos_dec;
     	/*Error dperp*/ sigma_phase = sigma/rtilde;
		/*Ampl.d_perp*/ d_perp = (rtilde)/average_cos_dec;
		 
     	/*Amplitud r99*/r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     														// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		
		double error_plus, error_minus;
    	error_rtilde(rtilde,sigma,&error_plus,&error_minus, &rUL);	

		/*Ampl. d99*/   d99 = r99r/(average_cos_dec);
		/*Ampl. dUL*/   dUL = rUL/(average_cos_dec);
									// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		std::cout<<rtilde<<std::endl;
     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << phase/d2r << "\t"<< sigma_phase/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}



void ray_given_freq( double freq, const char* in_file, const char* out_file, 
					long long utci , long long utcf, g rayleigh){
	

	double a =0.0  , b=0.0, sumaN=0.0,  mean_energy=0.0 ;
	double rtilde,phase,prtilde,r99r,  rUL, d99, dUL;
	double sigma=0.0, sigma_phase=0.0, sigma_dperp=0.0;

	double d_perp, factor;
	double average_sin_theta, average_cos_dec;

	std::ofstream myfile ("throw");

	int Iterations=1;

	for (int i = 0; i < Iterations; ++i)
	{
		double freq1 = freq + i*0.01;
		std::cout << " Iteration "<< i +1 <<" of " <<Iterations<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &mean_energy,  
						 &average_sin_theta, 
						 &average_cos_dec, 
						 freq, utci, utcf, in_file);
		/*Normalize given events*/
		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;

		average_cos_dec/=sumaN;
		average_sin_theta/=sumaN;
		// mean_energy/=sumaN;

		/*Rayleigh Parameters*/
     	phase= atan(b/a);

     	if (a < 0) phase= phase+pi;
     	if (a>0 && b< 0) phase = phase +2.*pi;	

		/*Amplitude*/	rtilde 	= sqrt(a*a + b*b);
     	/*Probability*/	prtilde = exp(-sumaN*(rtilde)*(rtilde)/4.0);

     	/*Error*/		sigma = sqrt(2./sumaN);
		/*Error phase*/ sigma_dperp = sigma/average_cos_dec;
     	/*Error dperp*/ sigma_phase = sigma/rtilde;
		/*Ampl.d_perp*/ d_perp = (rtilde)/average_cos_dec;
		 
     	/*Amplitud r99*/r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     														// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
		
		double error_plus, error_minus;
    	error_rtilde(rtilde,sigma,&error_plus,&error_minus, &rUL);	

		/*Ampl. d99*/   d99 = r99r/(average_cos_dec);
		/*Ampl. dUL*/   dUL = rUL/(average_cos_dec);
		
		std::cout.precision(8);

		std::cout <<"\n\n_______Frecuencia:\t"<< freq<< " ___________"<< std::endl;
		
		std::cout <<"\nEvents:\t"		<< sumaN			<< std::endl;
		std::cout <<"Energía media:\t"	<< mean_energy<<"---"<<mean_energy/sumaN<< std::endl;
     	
		 std::cout <<"\nAmplitud r:\t"	<< rtilde			<< "+/-" << sigma<<std::endl;
		std::cout <<"upper_r:\t"		<< error_plus  	<< std::endl;
		std::cout <<"lower_r:\t"  		<< error_minus	<< std::endl;
		std::cout <<"r99:\t\t"			<< r99r 			<< std::endl;
		std::cout <<"rUL:\t\t"			<< rUL 			<< std::endl;

		if (freq==366.25)
		{
		std::cout <<"\nd_perp:\t\t"		<< d_perp			<< "+/-" << sigma_dperp<<"\n";
		std::cout <<"upper_d:\t"		<< error_plus/average_cos_dec  	<< std::endl;
		std::cout <<"lower_d:\t"  		<< error_minus/average_cos_dec	<< std::endl;
		std::cout <<"d99:\t\t"			<< d99				<< std::endl;
		std::cout <<"dUL:\t\t"			<< dUL				<< std::endl;
		}
		
     	std::cout <<"\nProbabilidad:\t"	<< prtilde 			<< std::endl;
		std::cout <<"Fase:\t\t"			<< phase/d2r 		<< "+/-" << sigma_phase/d2r<<"\n" ;
		std::cout <<"Fase sigma \t"     << error_phase(rtilde,sigma,phase) << std::endl;
		std::cout <<"Fase sqrt \t"      << sigma_phase*sqrt(2)/d2r << std::endl;


		std::cout <<"\n\n<cos(dec)>:\t"	<< average_cos_dec  << std::endl;
		std::cout <<"<sin(theta)>:\t"	<< average_sin_theta<< std::endl;
	}

}
#endif // RAY

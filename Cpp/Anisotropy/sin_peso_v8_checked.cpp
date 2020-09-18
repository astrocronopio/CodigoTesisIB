#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

double pi 	= M_PI;
double d2r 	= pi/180.0;
double Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

double right_ascension(long long utc)
{	
	long long iutcref = 1104537600;
	double raz = (double)(utc-iutcref)/239.345 + 31.4971;

	raz = raz - int(raz/360.)*360.0;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}


void rayleigh( double *a , double *b, double *sumaN, double freq, 
				long long utci, long long utcf, const char* in_file)
{
	long long utc0 = 1072915200  ; //1/1/2005 00:00:00;
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			
			
			//liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 
			
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			
			// energy=Eraw;
			// if (energy<8.) continue;
			
			if(utcf < utc) break;
			if(utc  < utci || Theta > 80) continue;

			hrs=((double)(utc-utc0)/3600. + 31.4971*24./360.)*fas; // hora local
			peso =1.0;		
			*sumaN+=peso;
			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;

			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}

void ray_multifreq( int nf, const char* in_file, const char* out_file, long long utci , long long utcf){
	
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

     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}

void ray_given_freq( double freq, const char* in_file, const char* out_file, long long utci , long long utcf){
	

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

     	std::cout <<  "Frecuencia: "<< freq1 		<< "\t Amplitud: " << rtilde << "\t";
     	std::cout <<  "Probabilidad: "<<prtilde 	<< "\t Fase: " << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}




int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	long long utci = strtoul(argv[3], &pEnd, 0);  //1072915200;
	long long utcf =  strtoul(argv[4], &pEnd, 0); //1496275200;
	
	ray_multifreq(500,  in_file, out_file, utci, utcf);

/*	long long utci =  rango2013;
	long long utcf =  rango2020;
	ray_given_freq(366.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
	*/
	
	return 0;
}
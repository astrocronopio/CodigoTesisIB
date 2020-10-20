#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

#include "rayleigh.h"


void rayleigh( double *a , double *b, double *sumaN, double freq, 
				long long utci, long long utcf, const char* in_file)
{
	//long long utc0 = 1072915200  ; //1/>1/2005 00:00:00;  1104537600
	long long utc0 = 1104537600;
	
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	//std::vector<long double> dnhex(interval);
	//exposure_weight(dnhex, utci, utcf, *freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			

			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Eraw;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }
			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 
			if (energy<energy_threshold) continue;
			if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;

			hrs=((double)(utc-utc0)/3600. + 31.4971*24./360.)*fas; // hora local
			peso =1.0;	
			//nh 	= int(fmod(hrs*interval/24.0, interval));

			//peso= 1.0/dnhex[nh];			
			*sumaN+=peso;
			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;

			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}




int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	if (argc==6) energy_threshold =  strtoul(argv[5], &pEnd, 0);
	
	ray_multifreq(20,  in_file, out_file, utci, utcf, rayleigh);

/*	long long utci =  rango2013;
	long long utcf =  rango2020;
	ray_given_freq(366.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
	*/
	
	return 0;
}
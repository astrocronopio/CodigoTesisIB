#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

#include "east_west.h"


void east_west_method( 	double *a  , double *b		, double *sumaN , 
						double freq, long long utci , long long utcf,
						const char* in_file)
{
	//long long utc0 = 1072915200  ; //1/>1/2005 00:00:00;  1104537600
	long long utc0 = 1104537600;
	
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux , n_east, n_west;

	unsigned int east, west; 													


	std::ifstream myfile (in_file);

	//std::vector<long double> dnhex(interval);
	//exposure_weight(dnhex, utci, utcf, *freq);

	if (myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			

			liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w; 
			if (energy<energy_threshold) continue;
			if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;
			
			hrs=((double)(utc-utc0)/3600.)*fas; // hora local
	
			*sumaN+=1;
			raz = right_ascension(utc); //cenit Auger
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;

			if (abs(Phi) < 90 )
				east=1;
			
			if (east==1){
				n_east++;

			}


			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}


std::vector<double> average_over_cenit(long long utci, 
						long long utcf, 
						const char* in_file)
	{	
	double avg_cos_dec, avg_sin_dec;
	double avg_cos_2_dec, avg_sin_2_dec;
	double avg_c_s_dec, avg_c_s_2_dec;

	double avg_cos_the, avg_sin_the;
	double avg_cos_2_the, avg_sin_2_the;
	double avg_c_s_the, avg_c_s_2_the;

	long utc, nval;
	double Theta, Dec, Phi, Ra, aux;

	std::ifstream myfile (in_file);
	std::string line;
	std::vector<double> avg(10);

	if (myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			

			liness >> utc>>Phi>>Theta>>Ra>>Dec; 

			if(utc  < utci || Theta > 60) continue;
			if(utcf < utc) break;

			avg_cos_dec 	+= cos(Dec*d2r);
			avg_sin_dec 	+= sin(Dec*d2r);
			aux 			 = cos(Dec*d2r)*sin(Dec*d2r);
			avg_c_s_dec 	+= aux;
			avg_c_s_2_dec 	+= aux*aux;
			avg_cos_2_dec  	+= cos(Dec*d2r)*cos(Dec*d2r);
			avg_sin_2_dec  	+= sin(Dec*d2r)*sin(Dec*d2r);

			avg_cos_the 	+= cos(Theta*d2r);
			avg_sin_the 	+= sin(Theta*d2r);
			avg_c_s_the 	+= sin(Theta*d2r)*cos(Theta*d2r);
			avg_sin_2_the 	+= sin(Theta*d2r)*sin(Theta*d2r);	
			
			nval+=1;	
		}
	}
	

	avg[0] = avg_cos_dec/nval  ;    // Cos(dec)
    avg[1] = avg_c_s_dec/nval  ;   // Cos(dec)*Sin(dec)
    avg[2] = avg_c_s_2_dec/nval;    // Cos(dec)*Sin(dec)^2
    avg[3] = avg_cos_2_dec/nval;     // Cos(dec)^2
    avg[4] = avg_sin_the/nval  ;    // Sin(theta)
    avg[5] = avg_c_s_the/nval  ;   // Sin(theta)*Cos(theta)
    avg[6] = avg_sin_2_the/nval;     // Sin(theta)^2
    avg[7] = avg_cos_the/nval  ;    // Cos(theta)
    avg[8] = avg_sin_dec/nval  ;    // Sin(dec)
    avg[9] = avg_sin_2_dec/nval;    // Sin(dec)^2

	return avg;
	}

int main(int argc, char const *argv[])
{	
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	if (argc==6) energy_threshold =  strtoul(argv[5], &pEnd, 0);
	
	ew_multifreq(20,  in_file, out_file, utci, utcf, east_west_method);

/*	long long utci =  rango2013;
	long long utcf =  rango2020;
	ray_given_freq(366.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
	*/
	
	return 0;
}
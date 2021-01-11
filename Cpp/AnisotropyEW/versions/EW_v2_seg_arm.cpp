#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

#include "east_west.h"


void east_west_method( 	double *a  , double *b		, double *sumaN , 
						double *average_sin_theta	, double *average_cos_dec,
						double freq, long long utci , long long utcf,
						const char* in_file)
{
	long long utc0 = 1104537600  ; 
	
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38;
	double energy, Dec,energy_raw, energy_cor,ftr;
 
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, arg_1, hrs, peso,aux , n_east, n_west;

	unsigned int east, west; 													


	std::ifstream myfile (in_file);


	if (myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);	

			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Ecor;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }		



			// liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w; 
			// if (energy<energy_threshold) continue;
			// if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;
			
			hrs=((double)(utc-utc0)/3600. + 31.4971*24./360.)*fas; // hora local
			
			*sumaN+=1;
			raz = right_ascension(utc); //cenit Auger
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;


			east = abs(Phi) < 90 ? 0 : 1;

			*a +=cos(2*arg + pi*east ); 
			*b +=sin(2*arg + pi*east );	

			*average_sin_theta +=   sin(Theta*d2r);
			*average_cos_dec   +=	cos(Dec*d2r);
		}
	}

	myfile.close();
}


int main(int argc, char const *argv[])
{	
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); 
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); 
	if (argc==6) energy_threshold =  strtoul(argv[5], &pEnd, 0);
	

	std::cout<<"Output: "<<out_file<<std::endl;

	ew_multifreq(200, in_file, out_file, utci, utcf, east_west_method);

	ew_given_freq(365.25, in_file, out_file,
				  utci, utcf, east_west_method);

	ew_given_freq(366.25, in_file, out_file,
				  utci, utcf, east_west_method);
	
	return 0;
}
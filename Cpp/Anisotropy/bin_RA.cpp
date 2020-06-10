#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>
#include <iomanip>


unsigned long rango2013=1388577600; 
unsigned long rango2017=1472688000;
unsigned long rango2019=1546344000;
unsigned long rango2020=1577880000;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

const int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees

double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);

	double raz = aux/239.345 + 31.4971;

	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

float bin_RA_counter( const char* in_file, const char* out_file, unsigned long utci , unsigned long utcf)
{ 	
	double bandwidth= 360.0/interval;
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, aux, ang, utc, t5;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	std::string line;

	int x1,x2,x3;
	long double integral=0.0;

	std::ifstream myfile_in (in_file);
	std::ofstream myfile_out (out_file);

	std::vector<long double> dnhex(interval);

	if(myfile_in.is_open())
	{	
		while (!myfile_in.eof() ){			
			getline(myfile_in,line);			
			std::stringstream liness(line);			
			liness >> iutc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 			
			if (iutc < utci || iutc > utcf) continue;
			
			ang =  int(fmod(Ra*interval/360., interval));
			rnhexhr[ang] += 1;
			}
		}

		for (int i = 0; i < interval; ++i) integral +=rnhexhr[i]/interval;

		for (int i = 0; i < interval; ++i){myfile_out <<std::setprecision (17)<< i*360.0/288.0 << "\t" <<rnhexhr[i]/integral<<  std::endl;}

		myfile_out.close();
		myfile_in.close();
		}



int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;

	//unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	//unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	
	//ray_multifreq(400,  in_file, out_file, utci, utcf);

	bin_RA_counter( "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "bineado_RA_eventos.txt", utci, utcf);
	
	return 0;
}
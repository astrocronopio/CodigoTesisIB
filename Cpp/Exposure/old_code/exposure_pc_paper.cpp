#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

using namespace std;

long double pi 	= M_PI;
long double d2r 	= pi/180.0;
long double Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

long double T_S	= 366.25,  T_D = 365.25,  T_A=364.25 ;
 //every 5 min in sidereal time or every 1.25 sexagesimal degrees

long double right_ascension(long double utc)
{	long double iutcref = 1104537600;
	long double raz = (utc-iutcref)/239.345 + 31.4971;
	raz = raz - floor(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

void exposure_weight_sideral(vector<long double> & vect, unsigned long utci, unsigned long utcf, long double period)
{ 	int interval= 360;

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>vec_hex(interval);

	unsigned long  iutc, iutc0 = 1072915200;
	long double hex6, hex5;
	int iw,ib, hr;
	string line;
	float t,p,r,rav,x1,x2,x3;

	ifstream myweather("../../../Hexagons/utctprhdrc_010104_140916.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (ib==1 &&  iw<5){
				
				x1= right_ascension(iutc);
				hr =  int(x1)%360;
				num_hex_hr[hr] += hex6;
			}
		}
	}

	long double mean_ra = 0.0;
	for (int i = 0; i < interval; ++i) mean_ra+= num_hex_hr[hr]/360.000;

	for (int i = 0; i < interval; ++i)	vect[i]=num_hex_hr[i]/mean_ra;
	//integral+=vec_hex[i]/((long double)interval); 

	//for (int i = 0; i < interval; ++i) vect[i] = vec_hex[i];///integral;
}




long double exposure_given_sideral( long double freq, const char* out_file, long utci, long utcf){
	vector<long double> dnhex(360);
	ofstream myfile (out_file);

	exposure_weight_sideral(dnhex, utci, utcf, freq);

	for (int i = 0; i < 360; ++i)    	myfile <<  i << "\t"  <<dnhex[i]<<  endl;
}


int main(int argc, char const *argv[])
{	unsigned long utci =  1072915200;
	unsigned long utcf =  1451606400;

	const char* out_file_S = "./t_S.txt";

	exposure_given_sideral(T_S, out_file_S, utci, utcf);

	return 0;
}
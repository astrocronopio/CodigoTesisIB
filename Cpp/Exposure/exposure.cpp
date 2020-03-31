#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

using namespace std;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

double T_S	= 365.256363004,  T_D 	= 365.25;

int interval= 24; //every 5 min in sidereal time or every 1.25 sexagesimal degrees

long double right_ascension(long double utc)
{	long double iutcref = 1104537600;
	long double raz = (utc-iutcref)/239.345 + 31.4971;
	raz = raz - floor(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}


void exposure_weight_sideral(vector<long double> & vect, unsigned long utci, unsigned long utcf, long double period)
{ 	int inter= 360;

	std::vector<long double>num_hex_hr(inter);
	std::vector<long double>vec_hex(inter);

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
	for (int i = 0; i < inter; ++i) mean_ra+= num_hex_hr[hr]/360.000;

	for (int i = 0; i < inter; ++i)	vect[i]=num_hex_hr[i]/mean_ra;

}

long double exposure_given_sideral( long double freq, const char* out_file, long utci, long utcf){
	vector<long double> dnhex(360);
	ofstream myfile (out_file);

	exposure_weight_sideral(dnhex, utci, utcf, freq);

	for (int i = 0; i < 360; ++i)    	myfile <<  i << "\t"  <<dnhex[i]<<  endl;
}


void exposure_weight(vector<long double> & vect, unsigned long utci, unsigned long utcf, float period)
{ 
	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr;
	string line;
	float fas = period/365.25;
	long double x1,x2,x3;
	long double integral=0.0;

	ifstream myweather("../../../Weather/utctprh_05032020.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1){
				
				x1=((long double)(iutc-iutc0)/3600.+ 21.)*fas; //31.4971*24/360 es la hora siderea 2,099806667
				
				ihr =  int(x1)%interval ;//		else ihr =  interval +int(x1)%interval; 	

				num_hex_hr[ihr] += hex6;

				if (num_hex_hr[ihr]>1.0)
				{
					rnhexhr[ihr]+=num_hex_hr[ihr];
					num_hex_hr[ihr]=0.0;
				}
			}
		}
	}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i];
		integral+=rnhexhr[i]/((float)interval); 
	}

	
	for (int i = 0; i < interval; ++i) vect[i] = rnhexhr[i]/integral;
}


float exposure_given_period( float freq, const char* out_file){
	unsigned long utci =  1072915200;
	unsigned long utcf =  1451606400;

	vector<long double> dnhex(interval);

	ofstream myfile (out_file);

	exposure_weight(dnhex, utci, utcf, freq);

	for (int i = 0; i < interval; ++i)    	myfile <<  i << "\t"  <<dnhex[i]<<  endl;
}


int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* out_file_S = "./sideral.txt";
		unsigned long utci =  1072915200;
	unsigned long utcf =  1451606400;

	exposure_given_sideral(T_S, out_file_S, utci, utcf);

	const char* out_file = "./solar.txt";

	exposure_given_period(T_D, out_file);
	
	return 0;
}
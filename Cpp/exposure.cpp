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

int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees

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

	ifstream myweather("../../Weather/utctprh.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib>0.5){
				
				x1=(float(iutc-iutc0)/3600.+ 2.099807)*fas; //31.4971*24/360 es la hora siderea 2,099806667
				
				if (x1>=0)	ihr =  int(x1)%interval ;
				else ihr =  interval +int(x1)%interval; 	

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


float exposure_given_period( float freq, bool flag, const char* out_file){
	unsigned long utci =  flag ? 1372699409 :  1072915200;
	unsigned long utcf =  flag ? 1472688000 :  1544933508;

	vector<long double> dnhex(interval);

	ofstream myfile (out_file);

	exposure_weight(dnhex, utci, utcf, freq);

	for (int i = 0; i < interval; ++i)    	myfile << i << "\t"  <<dnhex[i]<<  endl;
}


int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* out_file_S = "./exposure_for_t_sideral_every_5min.txt";

	exposure_given_period(T_S, false, out_file_S);

	const char* out_file = "./exposure_for_t_non_sideral_every_5min.txt";

	exposure_given_period(T_D, false, out_file);
	
	return 0;
}
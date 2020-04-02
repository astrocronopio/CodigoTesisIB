#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>
#include <iomanip>

using namespace std;
//Global Parameters
float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

//Frequency in SIDEREAL DAYS
long double T_S	= 366.25,  T_D = 365.25,  T_A=364.25 ;



 double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);

	double raz = aux/(double)239.345 + (double)31.4971;

	raz = raz - int(raz/360.)*(double)360.00;
	if(raz<(double)0.0) raz = raz + (double)360.00;
	return raz;
}


void exposure_sideral( const char* out_file, unsigned long utci, unsigned long utcf)
{ 	int inter= 360;

	ofstream myfile (out_file);

	std::vector<long double>num_hex(inter, (long double)0.0);

	unsigned long  utc;
	long double hex6, hex5;
	int iw,ib, ang;
	string line;
	double t,p,r,rav,x2,x3;
	double x1;

	ifstream myweather("../../../Hexagons/utctprhdrc_010104_140916.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){	

			getline(myweather,line);			
			stringstream liness(line);	
			liness>>utc>>t>>p>>r>>rav>>hex6>>hex5>>iw>>ib;//>>x1>>x2>>x3;

			if (utc < utci || utc > utcf) continue;
			if (ib==1 &&  iw<5){

				x1= right_ascension(utc);
				ang =  int(x1)%360;
				if(hex6>1.0) num_hex[ang] = num_hex[ang] + hex6;
				//myfile <<setprecision (17)<<  x1 << endl;
			}
		}
	}

	long double mean_ra = (long double)0.0;

	for (int i = 0; i < inter; ++i){mean_ra+= num_hex[i]/(long double)360.000; }//cout << setprecision (17)<<num_hex[i] <<"\t" <<mean_ra << endl; }
	for (int i = 0; i < inter; ++i) myfile <<setprecision (17)<<  i <<"\t"<< num_hex[i]/mean_ra << "\t" << num_hex[i]<<  endl;
}	

/*
void exposure_given_period(float freq, const char* out_file, unsigned long utci, unsigned long utcf)
{ 	int interval= 24; //every 5 min in sidereal time or every 1.25 sexagesimal degrees

	vector<long double> dnhex(interval);

	ofstream myfile (out_file);

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr;
	string line;
	float fas = freq/365.25;
	long double x1,x2,x3;
	long double integral=0.0;

	ifstream myweather("../../../Hexagons/utctprhdrc_010104_140916.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1){
				
				x1=((long double)(iutc-iutc0)/3600.+ 21.)*fas; // hora local
				
				ihr =  int(x1)%interval;

				if (hex6>00.0) rnhexhr[ihr]+=hex6;
			}
		}
	}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i];
		integral+=rnhexhr[i]/((float)interval); 
	}

	for (int i = 0; i < interval; ++i) myfile <<setprecision (17)<< i << "\t" <<rnhexhr[i]/integral<<  endl;
}*/


int main(int argc, char const *argv[])
{
	const char* out_file_S = "./sideral.txt";
	
	unsigned long utci =  1104537600; //2005
	unsigned long utcf =  1451606400; //2016

	exposure_sideral(out_file_S, utci, utcf);

	const char* out_file = "./solar.txt";

	//exposure_given_period(T_D, out_file, utci, utcf);
	
	return 0;
}
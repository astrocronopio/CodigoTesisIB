#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>
#include <iomanip>

//Global Parameters
float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;


double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);
	double raz = aux/239.345 + 31.4971;
	raz = fmod(raz, 360.0); //	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

int method_weight_solar(int utc, float fas, int interval){
	unsigned iutc0 = 1072915200;

	double x1=((long double)(utc-iutc0)/3600. +31.4971*24./360.)*fas;
	double x2= fmod(x1, 24);
	
	int x3= int(x2*interval/24.0);
			
	return x3;
}


int method_weight_sidereal(int utc, float fas, int interval){
	float x3	=  	right_ascension(utc);
	int aux 	=  	int(x3*interval/360.);
	return aux;
}

void exposure_given_period(float freq, const char* out_file, unsigned long utci, unsigned long utcf, int interval, int (*f)(int, float, int))
{ 	double bandwidth= 360.0/interval;

	std::vector<long double> dnhex(interval);

	std::ofstream myfile (out_file);
	std::ifstream myweather("../../../Weather/utctprh_05032020.dat");

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, index, ang;
	std::string line;
	float fas = freq/365.25;
	long double x1,x2,x3;
	long double integral=0.0;

	if(myweather.is_open())
	{	
		while (!myweather.eof() )
		{			
			getline(myweather,line);			
			std::stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1)
			{
				index = (*f)(iutc, fas, interval);
				num_hex_hr[index] += 	hex6/5.0;
			
			//Esto lo hago para sumar numeros mas razonables, sumo cada un millon
				if(num_hex_hr[index]> 1000000.0 ) 
				{
					rnhexhr[index]	+=	num_hex_hr[index]/1000000.0;
					num_hex_hr[index]	=	0;
	}}}}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i]/1000000.0; //Y vuelvo a sumar lo que quedo
		integral+=rnhexhr[i]/((float)interval); 
	}

	for (int i = 0; i < interval; ++i){
		myfile <<std::setprecision (17) <<rnhexhr[i]/integral<< "\t" << rnhexhr[i]<< std::endl;}

	myfile.close();
	myweather.close();
}

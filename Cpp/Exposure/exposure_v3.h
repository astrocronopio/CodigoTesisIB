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

	double raz = aux/239.345 + 31.4971;

	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}


void exposure_given_period(float freq, const char* out_file, unsigned long utci, unsigned long utcf, int interval)
{ 	double bandwidth= 360.0/interval;

	vector<long double> dnhex(interval);

	ofstream myfile (out_file);
	ifstream myweather("../../../Weather/utctprh_05032020.dat");

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, aux, ang;
	string line;
	float fas = freq/366.25;
	long double x1,x2,x3;
	long double integral=0.0;

	if(myweather.is_open())
	{	
		while (!myweather.eof() )
		{			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1)
			{
				x3	=  	fmod(right_ascension(iutc)*fas, 360);
				ang =  	int(x3*interval/360.);
				num_hex_hr[ang] += 	hex6;
				aux	=	ang;

				if(num_hex_hr[aux]> 1000000 ) 
				{
					rnhexhr[aux]	+=	num_hex_hr[aux]/1000000.0;
					num_hex_hr[aux]	=	0;
	}}}}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i]/1000000.0;
		integral+=rnhexhr[i]/((float)interval); 
	}

	for (int i = 0; i < interval; ++i){
		myfile <<setprecision (17)<< i*360.0/288.0 << "\t" <<rnhexhr[i]/integral<< "\t" << rnhexhr[i]<<  endl;}

	myfile.close();

}

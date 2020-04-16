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


void exposure_sideral( const char* out_file, unsigned long utci, unsigned long utcf, int interval)
{ 	ofstream myfile (out_file);

	std::vector< double>num_hex(interval);

	 long  iutc;
	 double hex6, hex5;
	int iw,ib, ang;
	string line;
	double t,p,r,rav,x2,x3;
	double x1, aux, raz;

	long long iutcref = 1104537600;

	ifstream myweather("../../../Hexagons/hexagons_2018/utctprhdrc_010104_180219.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib;//>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1){
				
				x1= right_ascension(iutc);
				cout << iutc <<endl;
				ang =  int(x1*interval/288.);
				num_hex[ang] += hex6;
				//myfile <<setprecision (17)<<  x1 << endl;
			}
		}
	}

	long double mean_ra = (long double)0.0;

	for (int i = 0; i < interval; ++i)
		{mean_ra+= num_hex[i]; } 
		mean_ra=mean_ra/(long double)interval; //cout << setprecision (17)<<num_hex[i] <<"\t" <<mean_ra << endl; }
	for (int i = 0; i < interval; ++i) myfile <<setprecision (17)<<  i <<"\t"<< num_hex[ i]/mean_ra << "\t" << num_hex[i]<<  endl;

	//myfile.close();
	myweather.close();
}	


void exposure_given_period(float freq, const char* out_file, unsigned long utci, unsigned long utcf, int interval)
{ 	//int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees
	double bandwidth= 360.0/interval;

	vector<long double> dnhex(interval);

	ofstream myfile (out_file);

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, aux;
	string line;
	float fas = freq/365.25;
	long double x1,x2,x3;
	long double integral=0.0;

	ifstream myweather("../../../Hexagons/hexagons_2018/utctprhdrc_010104_180219.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib;//>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib==1){
				
				x1=((long double)(iutc-iutc0)/3600.+ 21.)*fas*interval/24.0; // hora local
				
				ihr =  int(x1)%interval >= 0 ? int(x1)%interval :  interval+int(x1)%interval  ;
				//aux=  int(ihr/bandwidth);
				aux=ihr;
				num_hex_hr[aux]+=hex6;
				
				if(num_hex_hr[aux]> 1 ) {
					rnhexhr[aux]+=num_hex_hr[aux];
					num_hex_hr[aux]=0;
				}

			}
		}
	}
	cout << "llegué" <<endl;
	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i];
		integral+=rnhexhr[i]/((float)interval); 
	}

	for (int i = 0; i < interval; ++i){myfile <<setprecision (17)<< i << "\t" <<rnhexhr[i]/integral<<  endl;}

	//myfile.close();
	myweather.close();
}


int main(int argc, char const *argv[])
{
	
	
	unsigned long utci =  1104537600; //2005
	unsigned long utcf =  1451606400; //2016
	
	int interval = 24;
	const char* out_file_S 	= "./sideral_24.txt";
	const char* out_file 	= 	"./solar_24.txt";
	const char* out_file_a 	= 	 "./anti_24.txt";

	//exposure_sideral( out_file_S, utci, utcf, interval);
	//exposure_given_period(T_D, out_file, utci, utcf, interval);
	//exposure_given_period(T_A, out_file_a, utci, utcf, interval);
/*	


	interval = 360;
	const char* out_file_S_1 	= "./sideral_360.txt";
	const char* out_file_1 		= 	"./solar_360.txt";
	const char* out_file_a_1 	= 	 "./anti_360.txt";
	exposure_given_period(T_S, out_file_S_1, utci, utcf, interval);
	exposure_given_period(T_D, out_file_1, utci, utcf, interval);
	exposure_given_period(T_A, out_file_a_1, utci, utcf, interval);
	
*/


	 interval = 288;
	const char* out_file_S_2 	= "./sideral_288.txt";
	const char* out_file_2 		= 	"./solar_288.txt";
	const char* out_file_a_2 	= 	 "./anti_288.txt";

	std::cout << "Sidereal "<< std::endl;
	exposure_given_period(T_S, out_file_S_2, utci, utcf, interval);
	
	std::cout << "Solar "<< std::endl;

	exposure_given_period(T_D, out_file_2, utci, utcf, interval);
	std::cout << "Anti-sidereal "<< std::endl;
	
	exposure_given_period(T_A, out_file_a_2, utci, utcf, interval);

	return 0;
}
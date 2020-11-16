#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

#include "rayleigh.h"

void exposure_weight(std::vector<long double> & vect, unsigned long utci, unsigned long utcf, double period)
{ 	
	double bandwidth= 360.0/interval;

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1104537600;
	double t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, aux, ang;
	
	std::string line;

	double fas = period/365.25; //aca tambien cambie para que la fase sea 1 vuelta en a sidereal year
	long double x1,x2,x3, integral=0.0;

	std::ifstream myweather("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_05032020.dat");


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
				aux = method_weight_solar(iutc, fas, interval);
				num_hex_hr[aux] += 	hex6;
			
			//Esto lo hago para sumar numeros mas razonables, sumo cada un millon
				if(num_hex_hr[aux]> 1000000.0 ) 
				{
					rnhexhr[aux]	+=	num_hex_hr[aux]/1000000.0;
					num_hex_hr[aux]	=	0.00;
	}}}}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i]/1000000.0; //Y vuelvo a sumar lo que quedo
		integral+=rnhexhr[i]/((double)interval); 
	}

	for (int i = 0; i < interval; ++i) vect[i] = rnhexhr[i]/integral;
}

void rayleigh( 	double *a 		, double *b, 
				double *sumaN	, double freq, 
				long long utci	, long long utcf, 
				const char* in_file )
{
	long long utc0 = 1072915200  ; //1/1/2005 00:00:00;
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			
		 
			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Eraw;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }
			
			liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w;
			if (energy<energy_threshold) continue;
			if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;
			raz = right_ascension(utc);
			hrs=((double)(utc-utc0)/3600. + 31.4971*24./360.)*fas; // hora local
			//peso =1.0;	
			
			nh 	= int(fmod(hrs*interval/24.0, interval));
			peso= 1.0/dnhex[nh];			
			*sumaN+=peso;
			
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;

			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}


void DipoloRA( 	double *a 		, double *b, 
				double *sumaN	, double freq, 
				long long utci	, long long utcf, 
				const char* in_file )
{
	long long utc0 = 1104537600  ; //1/1/2005 00:00:00;
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			
		 
			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Eraw;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }
			
			liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w;
			if (energy<energy_threshold) continue;
			if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;
			raz = right_ascension(utc);
			nh 	= int(fmod(raz*interval/360.0, interval));
			peso= 1.0/dnhex[nh];			
			*sumaN+=peso;
			
			arg = Ra*d2r;

			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}


void DipoloSolar(double *a 		, double *b, 
				double *sumaN	, double freq, 
				long long utci	, long long utcf, 
				const char* in_file )
{
	long long utc0 = 1072915200  ; //1/1/2005 00:00:00;
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			
		 
			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Eraw;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }
			
			liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w;
			if (energy<energy_threshold) continue;
			if(utc  < utci || Theta > 60) continue;

			if(utcf < utc) break;
			
			hrs=((double)(utc-utc0)/3600. + 21)*fas; // hora local
			//peso =1.0;	
			
			nh 	= int(fmod(hrs*interval/24.0, interval));
			peso= 1.0/dnhex[nh];			
			*sumaN+=peso;

			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0);

			*a +=cos(arg)*peso; 
			*b +=sin(arg)*peso;
		}
	}

	myfile.close();
}


int main(int argc, char const *argv[])
{	
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	if (argc==6) energy_threshold =  strtoul(argv[5], &pEnd, 0);

	ray_multifreq(40,  in_file, out_file, utci, utcf, rayleigh);

/*	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;
	ray_given_freq(365.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
*/	
	
	return 0;
}
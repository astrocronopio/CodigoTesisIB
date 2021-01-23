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

void rayleigh( 	double *a  , double *b		, double *sumaN , double *mean_energy,
				double *average_sin_theta	, double *average_cos_dec,
				double freq, long long utci , long long utcf,
				const char* in_file)
{
	long long utc0 = 1072915200  ; //1/1/2005 00:00:00;
	std::string line;

	long long utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor,UTC;

	double fas = freq/365.25, raz, arg, hrs, weight_hexagon,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() )
		{			
			getline(myfile,line);			
			std::stringstream liness(line);			

			/**/
			// {
			// liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			// energy=Ecor;
			// if (energy<8.) continue;
			// if(utc  < utci || Theta > 80) continue;
			// }		
			
			//	Less energy 4 EeV
			// {
			// 	liness>>AugId>>utc>>Phi>>Theta>>Dec>>Ra>>energy;
			// 	if (energy < 2 || energy >= 4) continue;
			// 	if(utc  < utci || Theta > 60) continue;
			// }	
			
			// //	Over energy 4 EeV
			// {
			// 	liness>>AugId>>Dec>>Ra>>energy>>utc>>Theta>>Phi>>t5>>ftr;
			// 	if (energy < 16 || energy >= 32) continue;
			// 	if (utc  < utci || Theta > 80) continue;
			// }	

			{			
			liness >> utc>>Phi>>Theta>>Ra>>Dec>>s1000>>s38>>energy>>t5>>s1000_w; 
			//if (energy<energy_threshold) continue;
			if(utc  < utci) continue;
			if(Theta > 60) continue;
			}

			if(utcf < utc) break;
			raz = right_ascension(utc);
			// hrs=((double)(utc-utc0)/3600. + 31.4971*24./360.)*fas; // hora local
			hrs=((double)(utc-utc0)/3600.)*fas; // GMT time in solar frequency
			//weight_hexagon =1.0;	
			
			nh 	= int(fmod(hrs*interval/24.0, interval));
			weight_hexagon= 1.0/dnhex[nh]; //1.0/(dnhex[nh]*(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-30.*d2r)));		
			*sumaN+=weight_hexagon;

			arg = 2.0*pi*(hrs/24.0 +2.099/24.0) + (Ra-raz)*d2r;
			
			arg = freq==366.25? Ra*d2r : arg;
			*a +=cos(arg)*weight_hexagon; 
			*b +=sin(arg)*weight_hexagon;

			*mean_energy 	   += 	energy*weight_hexagon;
			*average_sin_theta +=   weight_hexagon*sin(Theta*d2r);
			*average_cos_dec   +=	weight_hexagon*cos(Dec*d2r);
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

	// ray_multifreq(200,  in_file, out_file, utci, utcf, rayleigh);

/*	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;
	
*/	
	ray_given_freq(365.25,  in_file, out_file, utci, utcf, rayleigh);
	return 0;
}
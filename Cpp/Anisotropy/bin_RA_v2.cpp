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

const int interval= 12; //every 5 min in sidereal time or every 1.25 sexagesimal degrees


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

	float x1=((long double)(utc-iutc0)/3600. +  2.099806667)*fas; // hora local
	int	aux=  int(fmod(x1*interval/24.0, interval));
				
	return aux;
}


void exposure_weight(std::vector<long double> & vect, unsigned long utci, unsigned long utcf, float period)
{ 	
	double bandwidth= 360.0/interval;

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr, aux, ang;
	
	std::string line;

	float fas = period/365.25; //aca tambien cambie para que la fase sea 1 vuelta en a sidereal year
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
				num_hex_hr[aux] += 	hex6/5.0;
			
			//Esto lo hago para sumar numeros mas razonables, sumo cada un millon
				if(num_hex_hr[aux]> 1000000.0 ) 
				{
					rnhexhr[aux]	+=	num_hex_hr[aux]/1000000.0;
					num_hex_hr[aux]	=	0;
	}}}}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i]/1000000.0; //Y vuelvo a sumar lo que quedo
		integral+=rnhexhr[i]/((float)interval); 
	}

	for (int i = 0; i < interval; ++i) vect[i] = rnhexhr[i]/integral;
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

	float freq=365.25;

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile_in.is_open())
	{	
		while (!myfile_in.eof() ){			
			getline(myfile_in,line);			
			std::stringstream liness(line);			
			liness >> iutc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 			
			if (iutc < utci || iutc > utcf) continue;
			
			ang =  int( fmod((Ra)*interval/360., interval));
			aux =  method_weight_solar(iutc, 1, interval);
			
			ang = ang< 0? ang +360. : ang;
			rnhexhr[ang] += dnhex[aux];
			}
		}

		for (int i = 0; i < interval; ++i) integral +=rnhexhr[i]/interval;

		for (int i = 0; i < interval; ++i){myfile_out <<std::setprecision (17)<< i*360.0/interval +360*0.5/interval
													<< "\t" <<rnhexhr[i]/integral<< "\t" << rnhexhr[i] <<  std::endl;}

		myfile_out.close();
		myfile_in.close();
		}



int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)

	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;

	//unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	//unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	
	//ray_multifreq(400,  in_file, out_file, utci, utcf);

	bin_RA_counter( "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "bineado_RA_eventos_pesos.txt", utci, utcf);
	
	return 0;
}
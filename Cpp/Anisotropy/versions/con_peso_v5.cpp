#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

unsigned long rango2004=1072915200; // 01/01 00:00 GMT
unsigned long rango2005=1104537600; // 01/01 00:00 GMT

unsigned long rango2013=1388577600; 
unsigned long rango2017=1472688000;
unsigned long rango2019=1546344000;
unsigned long rango2020=1577880000;


float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

const int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees


double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);
	double raz = aux/239.345 + 31.4971;
	raz = fmod(raz, 360.0); //	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

int method_weight_solar(int utc, float fas, int interval){
	//unsigned iutc0 = 1072915200;
	unsigned iutc0  = 1104537600;
	float x1=((long double)(utc-iutc0)/3600. +  2.099806667)*fas; // hora local
	int	aux=  int(fmod(x1*interval/24.0, interval));
				
	return aux;
}


void exposure_weight(std::vector<long double> & vect, unsigned long utci, unsigned long utcf, float period)
{ 	
	double bandwidth= 360.0/interval;

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc;
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

void rayleigh( float *a 		 , float *b 		 , float *sumaN, float *freq, 
			   unsigned long utci, unsigned long utcf, const char* in_file)
{
	unsigned long utc0 = 1072915200,   iutcref = 1104537600  ; //1/1/2005 00:00:00;
	std::string line;

	int utc,t5, iw, nh;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;

	double fas = *freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, *freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			std::stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 

			if(utcf < utc) break;
			if(utc < utci || Theta > 60) continue;

			hrs =((double)(utc-iutcref)/3600.+31.4971*24/360)*fas;

			nh 	= int(fmod(hrs*interval/24.0, interval));

			peso= 1.0/dnhex[nh];		
			
			*sumaN+=peso;
			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;

			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	
	}
	myfile.close();
}

float ray_multifreq( int nf, const char* in_file, const char* out_file, unsigned long utci , unsigned long utcf){

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file );

	for (int i = 0; i < nf; ++i)
	{
		float freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}

float ray_given_freq( float freq, const char* in_file, const char* out_file, unsigned long utci , unsigned long utcf){

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	int iteracion=1;


	for (int i = 0; i < iteracion; ++i)
	{
		float freq_1 = freq + 0.01*i ;
		std::cout << " Iteration "<< i +1 <<" of " << iteracion<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &freq_1, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100

     	//std::cout << freq_1 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	//std::cout << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	
     	std::cout <<  "Frecuencia: "<< freq_1 		<< "\nAmplitud: " << rtilde << "\n";
     	std::cout <<  "Probabilidad: "<<prtilde 	<< "\nFase: " << pha/d2r  << "\nPercentil 99: "<< r99r << "\t"<< std::endl;
	}
}


int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	
	ray_multifreq(200,  in_file, out_file, utci, utcf);

	// unsigned long utci =  rango2013;
	// unsigned long utcf =  rango2020;
	// ray_given_freq(366.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
	
	
	return 0;
}
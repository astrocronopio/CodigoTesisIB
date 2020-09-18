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
	float x1=((long double)(utc-iutc0)/3600. +  2.099806667)*fas ; // hora local
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

void rayleigh( float *a1 , float *b1, float *a2 , float *b2,  float *sumaN, float freq, 
				unsigned long utci, unsigned long utcf, const char* in_file)
{
	unsigned long utc0 = 1072915200,   iutcref = 1104537600  ; //1/1/2005 00:00:00;
	std::string line;

	int utc,t5, iw, nh;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;

	double fas = freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			std::stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 

			if(utcf < utc) break;
			if(utc < utci || Theta > 60) continue;

			hrs =((double)(utc-iutcref)/3600.+31.4971*24/360)*fas ;

			nh 	= int(fmod(hrs*interval/24.0, interval));

			peso= 1.0/dnhex[nh];		
			
			*sumaN+=peso;
			raz = right_ascension(utc);
			arg = 2.0*pi*(hrs/24.0) + (Ra-raz)*d2r;


			*a1 +=cos(arg)*peso; 
			*b1 +=sin(arg)*peso;
			
			*a2 +=cos(2*arg)*peso; 
			*b2 +=sin(2*arg)*peso;
			}
	
	}
	myfile.close();
}

float ray_multifreq( int nf, const char* in_file, const char* out_file, unsigned long utci , unsigned long utcf){
	
	float a1 =0.0  , b1=0.0, a2=0, b2=0, sumaN=0.0 ;
	float rtilde1,pha1, prtilde1,r99r;
	float rtilde2,pha2, prtilde2;
	float sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	float freq=0.0;

	for (int i = 0; i < nf; ++i)
	{
		freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a1=0.0; b1=0.0; 
		a2=0.0; b2=0.0; 

		sumaN=0.0;

		rayleigh(&a1, &b1, &a2, &b2, &sumaN, freq, utci, utcf, in_file);

		a1 = 2.*a1/sumaN;
     	b1 = 2.*b1/sumaN;

		a2 = 2.*a2/sumaN;
     	b2 = 2.*b2/sumaN;

     	pha1= atan(b1/a1);
     	pha2 = atan(b2/a2);

     	if (a1 < 0) pha1= pha1+pi;
     	if (a1>0 && b1< 0) pha1= pha1 +2.*pi;

     	if (a2 < 0) pha2= pha2+pi;
     	if (a2>0 && b2< 0) pha2 = pha2 +2.*pi;

     	rtilde1= sqrt(a1*a1 + b1*b1);
     	prtilde1 = exp(-sumaN*rtilde1*rtilde1/4.0);
     	r99r  = sqrt(4.*log(100.)/sumaN); 

     	rtilde2= sqrt(a2*a2 + b2*b2);
     	prtilde2 = exp(-sumaN*rtilde2*rtilde2/4.0);
     	     		// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100

     	myfile << freq << "\t"		<< rtilde1 << "\t" << rtilde2 << "\t";
     	myfile 				<< pha1 << "\t" << pha2 << "\t";
     	myfile <<r99r<<std::endl;
     	
     	
	}
}

float ray_given_freq( float freq, const char* in_file, const char* out_file, unsigned long utci , unsigned long utcf){
	

	float a1 =0.0  , b1=0.0, a2=0, b2=0, sumaN=0.0 ;
	float rtilde1,pha1, prtilde1,r99r;
	float rtilde2,pha2, prtilde2;
	float sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	int Iterations=1;

	for (int i = 0; i < Iterations; ++i)
	{
		float freq1 = freq + i*0.01;
		std::cout << " Iteration "<< i +1 <<" of " <<Iterations<< std::endl;
		
				
		a1=0.0; b1=0.0; 
		a2=0.0; b2=0.0; 

		sumaN=0.0;

		rayleigh(&a1, &b1, &a2, &b2, &sumaN, freq, utci, utcf, in_file);

		a1 = 2.*a1/sumaN;
     	b1 = 2.*b1/sumaN;

		a2 = 2.*a2/sumaN;
     	b2 = 2.*b2/sumaN;

     	pha1= atan(b1/a1);
     	pha2 = 0.5*atan(b2/a2);

     	if (a1 < 0) pha1= pha1+pi;
     	if (a1>0 && b1< 0) pha1= pha1 +2.*pi;

     	if (a2 < 0) pha2= pha2+pi;
     	if (a2>0 && b2< 0) pha2 = pha2 +2.*pi;

     	rtilde1= sqrt(a1*a1 + b1*b1);
     	prtilde1 = exp(-sumaN*rtilde1*rtilde1/4.0);
     	r99r  = sqrt(4.*log(100.)/sumaN); 

     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde2;

     	rtilde2= sqrt(a2*a2 + b2*b2);
     	prtilde2 = exp(-sumaN*rtilde2*rtilde2/4.0);


     	std::cout << freq 	<< "\t"	<< rtilde1 << "\t" << rtilde2 << "\t";
     	std::cout     	<< "\t"	<< prtilde1 << "\t" << prtilde2 << "\t";
     	
     	std::cout 				<< pha1/d2r << "\t" << 0.5*pha2/d2r << "\t";
     	std::cout<< (sigma/rtilde1)/d2r<<"err"<<(sigma/rtilde2)/d2r <<"\t";
     	std::cout <<r99r<<std::endl;
     	
	}
}


int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	
/*	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;
	
	ray_multifreq(400,  in_file, out_file, utci, utcf);
*/
	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;
	ray_given_freq(365.25, "../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat", "auxiliar_anti.txt", utci, utcf);
	
	
	return 0;
}
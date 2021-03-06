#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

/*
version 8: Energy threshold as argumenter
*/

/// First approx

double pi 	= M_PI;
double d2r 	= pi/180.0;
double P0 	= 862.0, rho0	= 1.06;
double B= 1.042;
double y=3.29;
double Bb= B*(y-1.0);//2.36328;

const int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees


double energy_threshold=0;

double right_ascension(long long utc){	
	long long iutcref = 1104537600;
	double aux= (utc-iutcref);
	double raz = aux/239.345 + 31.4971;
	raz = fmod(raz, 360.0); //	raz = raz - int(raz/360.)*360.00;
	if(raz<0.0) raz = raz + 360.00;
	return raz;
}

int method_weight_solar(int utc, double fas, int interval){
	unsigned iutc0  = 1104537600;
	double x1=((long double)(utc-iutc0)/3600. )*fas +  2.099806667; // hora local
	int	aux=  int(fmod(x1*interval/24.0, interval));
				
	return aux;
}


void exposure_weight(std::vector<long double> & vect, unsigned long utci, unsigned long utcf, double period)
{ 	
	double bandwidth= 360.0/interval;

	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>aux_hex(interval);

	unsigned long iutc;
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
				num_hex_hr[aux] += 	hex6/5.0;
			
			//Esto lo hago para sumar numeros mas razonables, sumo cada un millon
				if(num_hex_hr[aux]> 1000000.0 ) 
				{
					aux_hex[aux]	+=	num_hex_hr[aux]/1000000.0;
					num_hex_hr[aux]	=	0;
				}
			}
		}
	}

	for (int i = 0; i < interval; ++i)
	{	
		aux_hex[i]+=num_hex_hr[i]/1000000.0; //Y vuelvo a sumar lo que quedo
		integral+=aux_hex[i]/((double)interval); 
	}

	for (int i = 0; i < interval; ++i) vect[i] = aux_hex[i]/integral;
}

void rayleigh( double *a 		 , double *b 		 , double *sumaN, double *freq, 
			   unsigned long utci, unsigned long utcf, const char* in_file)
{
	unsigned long utc0 = 1072915200 ; //1/1/2005 00:00:00;
	std::string line;

	int utc,t5, iw, nh;
	double Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;

	double fas = *freq/365.25, raz, arg, hrs, peso,aux; 													

	std::ifstream myfile (in_file);

	std::vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, *freq);

	double AugId, ds1000, Ecor, Eraw;

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			std::stringstream liness(line);			
			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 
			
			/*Para obtener lo del paper(reference), se necesita poner 
			//For PC data
			//liness>> AugId>>Dec>>Ra>>Eraw>>Ecor>>utc>>Theta>>Phi>>t5>>ftr;
			
			energy=Eraw
			Theta > 80 
			long long utci = 1072915200double y=3.29;
			double By= B*(y-1.0);//2.36328;;
			long long utcf = 1496275200;
			*/

			if(utcf < utc) break;
			if(utc < utci || Theta > 60) continue;
			if(energy < energy_threshold) continue;

			hrs =((double)(utc-utc0)/3600.+31.4971*24.0/360.0)*fas ;
			// UTC0 tiene que ser utcref para que cuenten igual con el RA!!!!!!!!
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

void ray_multifreq( int nf, const char* in_file, const char* out_file, 
					unsigned long utci , unsigned long utcf){

	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file );

	for (int i = 0; i < nf; ++i)
	{
		double freq = 363.25 + i*4.0/nf;

		std::cout << " Iteration "<< i +1 <<" of " << nf<< std::endl;
		
		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, &freq, utci, utcf, in_file);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	
     	rtilde= sqrt(a*a + b*b);
     	std::cout<<rtilde<<std::endl;
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(100.)/sumaN); 	// ESE 100 ES PORQUE HABÍA UN SIGNO ADELANTE, 
     										// QUE LO INTERCAMBIE POR LA INVERSA DE 0.01 QUE ES 100
     	myfile << freq 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< std::endl;
	}
}

void ray_given_freq( 	double freq, 
						const char* in_file, const char* out_file, 
						unsigned long utci , unsigned long utcf)
{

	double a =0.0  , b=0.0, sumaN=0.0 ;
	double rtilde,pha,prtilde,r99r;
	double sigma=0.0, sgmra=0.0;

	std::ofstream myfile (out_file);

	int iteracion=1;


	for (int i = 0; i < iteracion; ++i)
	{
		double freq_1 = freq + 0.01*i ;
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
{	
	// true		== short range,  
	// false	== long range (only for ICRCs)
	
	const char* in_file = argv[1];
	const char* out_file= argv[2];
	char * pEnd;

	unsigned long utci =  strtoul(argv[3], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcf =  strtoul(argv[4], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;

	if (argc==6) energy_threshold =  strtoul(argv[5], &pEnd, 0);

	std::cout<<"Eth: "<<energy_threshold<<std::endl;

	ray_multifreq(100,  in_file, out_file, utci, utcf);

	/*	
	unsigned long utci =  rango2013;
	unsigned long utcf =  rango2020;
	ray_given_freq(360, "../../Cpp/Energy_Reconstruction/test", "auxiliar_anti.txt", utci, utcf);
	*/
	
	return 0;
}
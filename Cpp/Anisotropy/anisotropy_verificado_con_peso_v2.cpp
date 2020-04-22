#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

using namespace std;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03, P0 	= 862.0, rho0	= 1.06;

double T_S	= 23.9344696,  T_D 	= 24.0;

//const char* in_file = "../../AllTriggers/AllTriggers_8EeV.dat";
//const char* out_file= "AllTriggers_Oscar_data_file_Eraw_8EeV_hex_short_range.txt" ;

const int interval= 288; //every 5 min in sidereal time or every 1.25 sexagesimal degrees

void exposure_weight(vector<long double> & vect, unsigned long utci, unsigned long utcf, float period)
{ 
	std::vector<long double>num_hex_hr(interval);
	std::vector<long double>rnhexhr(interval);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr;
	string line;
	float fas = period/366.2559; //aca tambien cambie para que la fase sea 1 vuelta en a sidereal year
	long double x1,x2,x3;
	long double integral=0.0;

	ifstream myweather("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_05032020.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib>0.5){
				
				x1=(float(iutc-iutc0)/3600.+ 2.099807)*fas; //31.4971*24/360 es la hora siderea 2,099806667
				
				if (x1>=0)	ihr =  int(x1)%interval ;
				else ihr =  interval +int(x1)%interval; 	

				num_hex_hr[ihr] += hex6;  ///ATENDE ACA  QUE TENES QUE CAMBIAR CUANDO A 1-2 EeV

				if (num_hex_hr[ihr]>1.0)
				{
					rnhexhr[ihr]+=num_hex_hr[ihr];
					num_hex_hr[ihr]=0.0;
				}
			}
		}
	}

	for (int i = 0; i < interval; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i];
		integral+=rnhexhr[i]/((float)interval); 
	}

	
	for (int i = 0; i < interval; ++i) vect[i] = rnhexhr[i]/integral;
}

double right_ascension(unsigned long utc, unsigned long iutcref)
{
	double raz = double(utc-iutcref)/239.345 + 31.4971;
	raz = raz - floor(raz/360.)*360.;
	if(raz<0.0) raz = raz + 360;
	return raz;
}


void rayleigh( float *a , float *b, float *sumaN, 
				float *freq, unsigned long utci, unsigned long utcf,
				const char* in_file)
{
	unsigned long utc0 = 1072915200,   iutcref = 1104537600  ; //1/1/2005 00:00:00;
	string line;

	int utc,t5, iw, nh;
	float Phi,Theta,Ra,s1000, s1000_w, s38, energy, Dec,energy_raw, energy_cor,ftr;

	double fas = *freq/366.2559, raz, arg, hrs, peso; 	//cambie de 265.25 a este valor, 
														//es acá donde da una vuelta en el circulo sidereo

	ifstream myfile (in_file);
	//ifstream myfile ("../Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat");


	vector<long double> dnhex(interval);
	exposure_weight(dnhex, utci, utcf, *freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			stringstream liness(line);			
			liness >> utc>>Phi>>Theta>>Ra>>s1000>>s38>>energy>>t5>>s1000_w; 

			if(utcf < utc) break;
			if(utc < utci || Theta > 80) continue;

			hrs= (float(utc - utc0)/3600.0 + 31.4971*T_D/360.0)*fas;

			if (int(hrs)%interval>=0) nh= (int(hrs)%interval); else  	nh=interval+(int(hrs)%interval)  ;
		
			peso =1.0/dnhex[nh];
			
			*sumaN+=peso;
			raz = right_ascension(utc, iutcref);

			arg = 2.0*pi*hrs/T_D + (Ra-raz)*d2r;
			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	
	}
	myfile.close();
}

float ray_multifreq( int nf, bool flag, const char* in_file, const char* out_file){
	unsigned long utci =  flag ? 1372680068 :  1072959037;
	unsigned long utcf =  1577836799 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	ofstream myfile (out_file);

	for (int i = 0; i < nf; ++i)
	{
		float freq = 364 + i*3.0/nf;

		cout << " Iteration "<< i +1 <<" of " << nf<< endl;
		
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
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< endl;
	}
}


int main(int argc, char const *argv[])
{	// true		== short range,  
	// false	== long range (only for ICRCs)
	const char* in_file = argv[1];
	const char* out_file= argv[2];

	ray_multifreq(250, true, in_file, out_file);
	
	return 0;
}
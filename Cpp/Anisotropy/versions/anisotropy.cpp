#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
#include <vector>

using namespace std;

float pi 	= M_PI;
float d2r 	= pi/180.0;
float Bb	= 1.03;
float P0 	= 862.0;
float rho0	= 1.06;

float T_S_dia	= 23.9344696;
float T_D_dia 	= 24.0;

const char* in_file = "../../Herald/Central/Modified/Energy_above_1EeV/Old_herald_8EeV_oscar.dat";
const char* out_file= "../../Anisotropy/ICRC/2015/ICRC2015_data_file_Eraw_new_exp.txt" ;


float right_ascension(unsigned long utc, unsigned long iutcref) //Right ascension of the cenith of Auger
{
	float raz = float(utc-iutcref)/239.34469 + 31.4971;  //239.34469 es (dia sidereo en segundos)/(360 grados sexagesimales)
	raz = raz - int(raz/360.)*360.;
	if(raz<0.0) raz = raz + 360;
	return raz;
}

void exposure_weight(vector<long double> & vect, unsigned long utci, unsigned long utcf, float period)
{	std::vector<long double>num_hex_hr(24);
	std::vector<long double>rnhexhr(24);

	unsigned long iutc, iutc0 = 1072915200;
	float t,p,r,rav,hex6, hex5;
	int iw,ib, ihr;
	string line;
	float fas = period/365.25;
	long double x1,x2,x3;
	long double integral=0.0;

	ifstream myweather("../../Weather/utctprh.dat");

	if(myweather.is_open())
	{	
		while (!myweather.eof() ){			
			getline(myweather,line);			
			stringstream liness(line);	
			liness>>iutc>>t>>p>>r>>rav>>hex6>>hex5>> iw>>ib>>x1>>x2>>x3;

			if (iutc < utci || iutc > utcf) continue;
			if (iw<5 && ib>0.5){
				
				x1=(float(iutc-iutc0)/3600.+ 2.099807)*fas; //31.4971*24/360 es la hora siderea 2,099806667
				
				if (x1>=0)	ihr =  int(x1)%24 ;
				else ihr =  24+int(x1)%24; 	

				num_hex_hr[ihr] += hex6;

				if (num_hex_hr[ihr]>1.0)
				{
					rnhexhr[ihr]+=num_hex_hr[ihr];
					num_hex_hr[ihr]=0.0;
				}
			}
		}
	}

	for (int i = 0; i < 24; ++i)
	{	
		rnhexhr[i]+=num_hex_hr[i];
		integral+=rnhexhr[i]/24.0; 
	}

	
	for (int i = 0; i < 24; ++i) vect[i] = rnhexhr[i]/integral;

}

void rayleigh( float *a , float *b, float *sumaN, float period, unsigned long utci, unsigned long utcf)
{
	unsigned long utc0 = 1104537600; //1/1/2005 00:00:00;
	string line;

	int utc,t5, iw;
	float Phi,Theta,Ra,x1,x3,energy, p, r, rav, AugId,Dec,energy_raw, energy_cor,ftr;
	float arho, aP, brho;

	float fas = period/365.25;

	//ifstream myfile (in_file);
	ifstream myfile ("../Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat");

//	vector<long double> dnhex(24);
	//exposure_weight(dnhex, utci, utcf, period);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			stringstream liness(line);			
		//	liness >> utc>>Phi>>Theta>>Ra>>x1>>x3>>energy>>t5; //>> p>> r>> rav>> iw ;
			liness>> AugId >> Dec>> Ra>> energy_raw >> energy_cor >> utc >> Theta>>Phi>>t5>>ftr;
		energy=energy_raw;
			if(utc < utci || utc > utcf || Theta > 80 || t5 < 6  || energy< 8) continue; 
			if(utcf < utc) break;

			float  hrs= (float(utc - utc0)/3600.0 + 31.4971*24.0/360.0)*fas; // ésta es la ascensión recta.
			
			int nh = 0;

			//if (int(hrs)%24>=0) nh= (int(hrs)%24)>0; else  
			nh=24+(int(hrs)%24)  ;

			float peso =1.0;
			//float peso =1.0/dnhex[nh];

			*sumaN+=peso;
			float raz = right_ascension(utc, utc0);

			float arg = 2.0*pi*hrs/24.0 + (Ra-raz)*d2r;
		
			*a +=cos(arg)*peso;
			*b +=sin(arg)*peso;
			}
	}
	myfile.close();


}

void ray_multifreq(int nf){
	//int nf=50;
	unsigned long utci = 1072969615;//1372699409 ; //1072969615
	unsigned long utcf = 1535789456;//1496267276 ; //1535789456

	float a =0.0  , b=0.0, sumaN=0.0 ;
	float rtilde,pha,prtilde,r99r;
	float sigma=0.0, sgmra=0.0;

	ofstream myfile (out_file);

	for (int i = 0; i < nf; ++i)
	{	
		cout << " Iteration "<< i +1 <<" of " << nf<< endl;

		float period = 364.0 + i*3.0/nf;

		a=0.0; b=0.0; sumaN=0.0;

		rayleigh(&a, &b, &sumaN, period, utci, utcf);

		a = 2.*a/sumaN;
     	b = 2.*b/sumaN;
     	pha= atan(b/a);

     	if (a < 0) pha= pha+pi;
     	if (a>0 && b< 0) pha = pha +2.*pi;

     	rtilde= sqrt(a*a + b*b);
     	prtilde = exp(-sumaN*rtilde*rtilde/4.0);
     	sigma = sqrt(2./sumaN);
     	sgmra = sigma/rtilde;
     	r99r  = sqrt(4.*log(99.)/sumaN);

     	myfile << period 		<< "\t" << a << "\t" << b << "\t" << sigma << "\t" << rtilde << "\t";
     	myfile << prtilde 	<< "\t" << pha/d2r << "\t"<< sgmra/d2r << "\t"<< r99r << "\t"<< endl;
	}
}


int main(int argc, char const *argv[])
{	
	ray_multifreq(500);
	//cout<< int(-11)%7<< endl;
	return 0;
}
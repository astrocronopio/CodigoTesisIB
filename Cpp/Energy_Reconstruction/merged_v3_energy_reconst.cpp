 /*
################################################
################################################
####    1- ($8)   UTC                       ####
####    2- ($4)   Phi                       ####
####    3- ($3)   Theta                     ####
####    4- ($14)  Ra                        ####
####    5- ($12)  S1000 sin corregir        ####
####    6- ($47)  S38_w                     ####
####    7- ($38)  Energy                    ####
####    8- ($43)  Tanks                     ####
####    9- ($37)  S1000 con correccion      ####
################################################
################################################
*/



/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>

using namespace std;


float p0= 862;
float rho0=1.06;
float A= 0.185;
float B= 1.032;
float Bgamma= 2.36328;

float energy( float S38)
{
	return A*powf(S38, B);
}


float ap(float the2)
{
	return -0.0012 -0.0079*the2 + 0.0017*the2*the2;
}


float arho(float the2)
{
	return -2.2888  -0.2 *the2 + 3.605*the2*the2;
}


float brho(float the2)
{
	return  -0.7259 -0.1833 *the2 + 1.272 *the2*the2;
}


float energy_reconstruction(float S38, float p, float rho, float rhod, float the) 
{	float the2= sin(the*M_PI/180.)*(the*M_PI/180.);
	
	float factor =1+ (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/Bgamma;
	cout << factor << endl;
	float S38_w = S38/factor;

	return energy(S38_w);
}


int main(int argc, char** argv)
{
	ifstream eventdata 	(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	(argv[2]);

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		float x3,x4,x5,x6,x7;
		float i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		float the,	phi, S1000, S1000_raw, dS1000, Energy, energy_corr, S38, rho2, rho24, tanks;
		int utc;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc >> phi >> the >> ra >> S1000 >> S38 >> Energy >> tanks >> S1000_raw ;

			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 )
				{	
					energy_corr = energy_reconstruction( S38,  p,  rho, rhod, the) ;
					outfile << utc<<"\t"<< phi <<"\t" << the <<"\t"<< ra <<"\t";
					outfile << S1000<<"\t" << S38 << "\t" <<energy_corr <<"\t"<< tanks << "\t" << S1000_raw << "\n" ;

					outfile.flush();
					break;
				}

				else{
					getline(utctprh,lineatm);
					stringstream satm(lineatm);
					satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
					continue;
				}
			}			
		}
		eventdata.close();
		utctprh.close();
		outfile.close();
	}
	else cout << "Unable to open file"; 
	return 0;
}

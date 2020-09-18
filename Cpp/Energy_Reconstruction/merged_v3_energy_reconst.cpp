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

/* No necesita el merged con el clima porque lee la informacion del
archivo de clima */

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
float A= 0.19;
float B= 1.03;
float Bgamma= 2.36328;

float energy( float S38)
{
	return A*powf(S38, B);
}

//Reference
float c07 = 0.00159376 ;
float c17 = -0.0265173 ;
float c27 = 0.0263584  ;


// float c07   =-0.0053;//
// float c17   =0.0221;// 
// float c27   =-0.0298;//


float ap(float the2)
{
	return c07 + c17*the2 + c27*the2*the2;
}


//Reference
float c05 = -2.57342  ;
float c15 = 1.53895   ;
float c25 = 2.00658   ;



// float c05  = 0.77;// 
// float c15  = -1.196;// 
// float c25  = -0.483;// 

float arho(float the2)
{
	return c05 + c15*the2 + c25*the2*the2;
}

//Reference
float c06 = -1.02068   ;
float c16 = 1.27225    ;
float c26 = -0.0414128 ;


// float c06     = 0.39;//      
// float c16     = -1.210;//    
// float c26     = 0.5625;//    


float brho(float the2)
{
	return c06 + c16*the2 + c26*the2*the2;
}



float energy_reconstruction(float S38_sin_w, float p, float rho, float rhod, float the) 
{	float the2= sin(the*M_PI/180.)*(the*M_PI/180.);
	
	//Bien, se debe dividir porque  a =  Bgamma * alpha, y los parametros son de ap

	float factor =1 + (ap(the2)*(p-p0) + arho(the2)*(rho -  rho0) + brho(the2)*(rhod - rho))/Bgamma; 
	//cout << factor << endl;
	float S38 = S38_sin_w/factor;   // S = S_0 * factor, pero S_0 es para calcular la energia

	return energy(S38);
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
		
		float AugId, Dec, Eraw, Ecor, t5,ftr;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		

		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			//sevent >> utc >> phi >> the >> ra >> S1000 >> S38 >> Energy >> tanks >> S1000_raw ;
			sevent >>AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>t5>>ftr;

			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 )
				{	
					//Importante fijarse si S38 esta corregida  o no

					

					energy_corr = energy_reconstruction( S38*S1000/S1000_raw,  p,  rho, rhod, the) ;

					//outfile<< utc <<"\t" << Eraw <<"\t" <<Ecor <<"\t" <<energy_corr<< "\t" << (Ecor - energy_corr) <<"\n" ;
					std::cout<<energy_corr-Energy<<std::endl;
					// if ( energy_corr <1.0) break;
					// if (energy_corr>2.0) break;
					
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

// ######## O U T P U T ############################
// ################################################
// ####    1- ($8)   UTC                       ####
// ####    2- ($4)   Phi                       ####
// ####    3- ($3)   Theta                     ####
// ####    4- ($14)  Ra                        ####
// ####    5- ($12)  S1000 sin corregir        ####
// ####    6- ($47)  S38 / sin corrección      ####
// ####    7- ($38)  Energy                    ####
// ####    8- ($43)  Tanks                     ####
// ####    9- ($37)  S1000 con correccion      ####
// ################################################
// ################################################


/* 
No necesita el merged con el clima porque 
lee la informacion del archivo de clima 
*/

/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>


#include "recons.h"

using namespace std;


int main(int argc, char** argv)
{	

	ifstream eventdata 	(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	(argv[2]);
	ofstream outtest	("test.data");

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		double x3,x4,x5,x6,x7;
		double i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		double the,	phi, S1000, S1000_raw, dS1000, Energy, energy_corr, S38, rho2, rho24, tanks;
		int utc;
		
		double AugId, Dec, Eraw, Ecor, t5,ftr, factor;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		

		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc >> phi >> the >> ra >> Dec>> S1000 >> S38 >> Energy >> tanks >> S1000_raw ;
			//sevent >>AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>t5>>ftr;
			// cout<<lineev<<endl;
			
			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 )
				{	if  (iutc<1388577500 || tanks<6) break;
					//Importante fijarse si S38 esta corregida  o no

					// Analisis  S38: no corregida por el Herald
					//if (flag==0 || flag==3) 
						energy_corr = energy_reconstruction(S38 , p,  rho2, rho24, the, phi, &factor) ;
					
					// Analisis Energia: S38 corregido por el Herald
					//if (flag==1 || flag==2) 
						// energy_corr = energy(S38*(S1000_raw/S1000));//energy_reconstruction(S38*(S1000_raw/S1000), p,  rho24, rhod, the, phi, &factor) ;
						
					//energy_corr=Energy;

					if (energy_corr < 1.0) break;
					if (energy_corr > 2.0) break;
					
					std::cout<<"Delta:  "<<energy_corr-Energy<<std::endl;
					outtest << utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) << "\t";
					outtest << energy(S38*(S1000/S1000_raw))<< "\t" << S1000/S1000_raw << "\t" <<factor<<"\n" ;
					//outfile<< utc <<"\t" << 0 <<"\t" <<Energy <<"\t" <<energy_corr<< "\t" << (Energy - energy_corr) <<"\n" ;

					outfile << utc<<"\t"<< phi <<"\t" << the <<"\t"<< ra <<"\t";
					outfile << S1000<<"\t" << S38 << "\t" <<energy_corr <<"\t";
					outfile << tanks << "\t" << S1000_raw << "\n" ;

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

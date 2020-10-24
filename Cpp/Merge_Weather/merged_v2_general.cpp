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

using namespace std;

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
		float the,	phi, S1000, S1000_raw, dS1000, Energy, S38, rho2, rho24, tanks;
		int utc;

		float AugId, Dec, Eraw, Ecor, ftr;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			
			sevent >> utc >> phi >> the >> ra >> dec >> S1000 >> S38 >> Energy >> tanks >> S1000_raw ;
			
			//pc DATA
			//sevent >> AugId>>Dec>>ra>>Eraw>>Ecor>>utc>>the>>phi>>tanks>>ftr;


			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 )
				{	/// Asuming iutc as the end second of each 5 min bin				
					
					outfile << utc<<"\t"<< the <<"\t"<< Energy <<"\t"<< p << "\t" << rho <<"\t"<< rhod << "\t" <<  iw <<"\n" ;
					
					// //PC data
					// outfile << utc<<"\t"<< the <<"\t"<< Eraw<< "\t"<< Ecor ;
					// outfile <<"\t"<< p << "\t" << rho <<"\t"<< rhod << "\t" <<  iw <<"\n" ;

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

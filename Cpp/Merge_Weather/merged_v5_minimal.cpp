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
	ifstream eventdata 	("../../../AllTriggers/Original_Energy/2019/AllTriggers_2019.dat");//(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");
	ofstream outfile 	("../../../AllTriggers/Original_Energy/2019/AllTriggers_2019_merged.dat");//(argv[2]);

	string lineev;
	string lineatm;
	
	if(eventdata.is_open() && utctprh.is_open())	
	{
		long iutc;		
		double t,p,rho,rhod,h6,h5,iw,ib;
		double  rho2, rho24;
		long utc;

		float AugId, Dec, Eraw, Ecor, ftr;

		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);	
			stringstream sevent(lineev);			
			sevent>>utc;
			
			while (!utctprh.eof() ){			
				if(utc <= iutc && utc> iutc-300 && !lineev.empty() )
				{	
					outfile << lineev <<"\t"<< p << "\t" << rho <<"\t"<< rhod << "\t" <<  iw <<"\n" ;
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

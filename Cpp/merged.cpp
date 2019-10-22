/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main(int argc, char** argv)
{
	ifstream eventdata ("../../Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat"); /// Archive.bz2 file already filtered by filter_by_energy.sh
	ifstream utctprh ("../../Weather/utctprh.dat");/// weather info file in 5 min bins 
	ofstream outfile ("../../Merged_Herald_Weather/Another_way_around/Old_herald_weather_S38.dat"); /// output file	
	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		float x3,x4,x5,x6,x7;
		string i1,t,p,rho,rho2,rhod,h6,h5,iw,ib;
		float The,	phi, S1000, dS1000, Energy;
		int UTC;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy 	;

			while (!utctprh.eof() ){			
				if(UTC <= iutc && UTC > iutc-300){			/// Asuming iutc as the end second of each 5 min bin				
					outfile << lineev <<  " " << iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib <<endl; /// Appends weather info 
					break;
				}
				else{
					getline(utctprh,lineatm);
					stringstream satm(lineatm);
					satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;
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

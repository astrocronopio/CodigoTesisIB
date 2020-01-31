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
	ifstream utctprh 	(argv[2]);
	ofstream outfile 	(argv[3]);

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		float x3,x4,x5,x6,x7;
		float i1,t,p,rho,rhod,h6,h5,iw,ib, ra;
		float the,	phi, S1000, dS1000, Energy, S38, rho2, rho24, tanks;
		int utc;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			//sevent >> utc 	 >>	phi  >>	the>> 	S1000 >> 	dS1000 >>	Energy 	;
			sevent >> utc >> phi>>the >> ra>>x3>>x4>>Energy>>tanks ;

			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300 ){			/// Asuming iutc as the end second of each 5 min bin				
					//outfile << "\t" <<utc<< "\t"  << phi<< "\t"  << the<< "\t"  << S1000<< "\t"  << dS1000<< "\t"  << Energy<< "\t"  << p<< "\t"  << rho<< "\t"  << rhod<< "\t"  << iw<< "\n" ; /// Appends weather info 
					outfile << utc<<"\t"<< phi<<"\t"<<   the <<"\t"<< ra <<"\t"<<x3 <<"\t"<< x4<<"\t"<< Energy <<"\t"<< tanks<<"\t"<< p<<"\t"<< rho <<"\t"<< rhod<<"\t"<< iw<<"\t"<< ib<<"\n" ; /// Appends weather info 4515					//cout<<"xd"<<endl;
					//cout<< iutc<<'\t'<<utc-iutc<<'\t'<< ib<<endl;
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

/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main(int argc, char** argv)
{
	ifstream eventdata 	("../../../AllTriggers/Original_Energy/2017/AllTriggers_1EeV_2017.dat");//(argv[1]);
	ifstream utctprh 	("../../../Weather/utctprh_delay.dat");//(argv[2]);
	ofstream outfile 	("../../../AllTriggers/Original_Energy/2017/AllTriggers_1EeV_2017_merged_nobp.dat");//(argv[3]);

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		float x3,x4,x5,x6,x7;
		string i1,t,p,rho,rhod,h5,iw;
		float the,	phi, S1000, S1000_w, Energy, rho2, rho24,h6, S38, ra;
		int utc, tanks, ib;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);

		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;// >> rho2 >> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{	
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			//sevent >> utc 	 >>	phi  >>	the>> 	S1000 >> 	dS1000 >>	Energy 	;
			//sevent >> utc >>	the >>	Energy 	;
			sevent >> utc 	 >>	phi  >>	the>> ra >>	S1000 >> S38 >>	Energy >> tanks >> S1000_w 	;

			while (!utctprh.eof()){
				if(utc <= iutc && utc > iutc-300)
				{	
					if (ib==1)
					{
						outfile << utc<< "\t"  << the<< "\t" << S38 << "\t"<< Energy<< "\t"  << p<< "\t"  << rho<< "\t"  << rho24<< "\t"  << iw<< "\t" << "\n" ; /// Appends weather info 
						outfile.flush();
					}
					break;
				}
				else
				{
					getline(utctprh,lineatm);
					stringstream satm(lineatm);
					satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;// >> rho2 >> rho24;
					continue;
				}
			}			
		}
	}
	else cout << "Unable to open file";  exit;

		eventdata.close();
		utctprh.close();
		outfile.close();

	return 0;
}

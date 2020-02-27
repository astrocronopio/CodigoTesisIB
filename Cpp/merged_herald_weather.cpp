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
		string i1,t,p,rho,rhod,h5,iw,ib;
		float the,	phi, S1000, dS1000, Energy, rho2, rho24,h6;
		int utc;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);

		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;// >> rho2 >> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{	
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			//sevent >> utc 	 >>	phi  >>	the>> 	S1000 >> 	dS1000 >>	Energy 	;
			sevent >> utc >>	the >>	Energy 	;

			while (!utctprh.eof()){
				if(utc <= iutc && utc > iutc-300)
				{	outfile << utc<< "\t"  << the<< "\t" << Energy<< "\t"  << p<< "\t"  << rho<< "\t"  << rhod<< "\t"  << iw<< "\t" << ib <<"\n" ; /// Appends weather info 
					cout<< iutc<<'\t'<<utc-iutc<<'\t'<< ib<<endl;
					//outfile.flush();

					cout<<"pepe"<<endl;
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

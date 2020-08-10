/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main(int argc, char** argv)
{
	ifstream eventdata ("../../../AllTriggers/Original_Energy/2019/AllTriggers_1EeV_2019.dat"); /// Archive.bz2 file already filtered by filter_by_energy.sh
	ifstream utctprh ("../../../Weather/utctprh_delay.dat");/// weather info file in 5 min bins 
	ofstream outfile ("../../../AllTriggers/Original_Energy/2019/AllTriggers_1EeV_2019_merged_nobap.dat"); /// output file	

	//ifstream eventdata 	(argv[1]);
	//ifstream utctprh 	(argv[2]);
	//ofstream outfile 	(argv[3]);


	/////////////////////////////////////////////////////	
	//rho:
	
	//rhod:
	
	//rho2:

	//rho24:
	/////////////////////////////////////////////////////

	string lineev;
	string lineatm;
	if(eventdata.is_open() && utctprh.is_open())	
	{
		int i8,i2,iutc,i;		
		float x3,x4,x5,x6,x7;
		string i1,t,p,rho,rhod,h6,h5,iw;
		float the,	phi, ra, S1000, S1000_w, Energy, S38, rho2, rho24, tanks;
		int utc, ib;
		getline(utctprh,lineatm);
		stringstream satm(lineatm);
		satm >> iutc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib >> rho2>> rho24;
		
		while (!eventdata.eof() && !utctprh.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc 	 >>	phi  >>	the>> ra >>	S1000 >> S38 >>	Energy >> tanks >> S1000_w 	;
			//sevent >> utc 	>>	the >>	S38 >> Energy ;

			while (!utctprh.eof() ){			
				if(utc <= iutc && utc > iutc-300){			/// Asuming iutc as the end second of each 5 min bin				
					//outfile << "\t" <<utc<< "\t"  << phi<< "\t"  << the<< "\t"  << S1000<< "\t"  << dS1000<< "\t"  << Energy<< "\t"  << p<< "\t"  << rho<< "\t"  << rhod<< "\t"  << iw<< "\n" ; /// Appends weather info 
					
					if (ib==1) 
						{	outfile << utc<<"\t"<< the <<"\t"<< S38 <<"\t"<< Energy <<"\t"<< p<<"\t"<< rho <<"\t"<< rho24<<"\t"<< iw<<"\t"<< "\n" ; /// Appends weather info 4515					//cout<<"xd"<<endl;
							outfile.flush();
						}

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

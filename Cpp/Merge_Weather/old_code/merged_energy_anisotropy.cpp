/// Program to assign the weather info for each event from the Herald Archive
///
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>

using namespace std;

int main(int argc, char** argv)
{
	ifstream eventdata 	("../../../AllTriggers/AllTriggers.dat");
	ifstream utctprh 	("../../../AllTriggers/AllTriggers_new.dat");
	ofstream outfile 	("../../../AllTriggers/ArchiveAllTriggers_merged_energy.dat");

	string lineev;
	string lineatm;

	double S38_, dS1000, Energy, E, S38;
	int utc, iutc;

	if(eventdata.is_open() && utctprh.is_open())	
	{
			getline(utctprh,lineatm);
			stringstream satm(lineatm);
			satm >> iutc >> E >> S38; // 2020
	
		while (!eventdata.eof() )
		{
			getline(eventdata,lineev);			
			stringstream sevent(lineev);			
			sevent >> utc >> Energy >> S38_ ; //2017

			while (!utctprh.eof() ){			
				if(utc==iutc && utc > ){			
					outfile << utc <<'\t'<<log(E)<<'\t'<< log(Energy) << '\t' << log(S38) << '\t' << log(S38_) << '\t' <<  E - Energy << '\t' <<  E + Energy <<  endl;
					outfile.flush();
					break;
				}
				else if (utc>iutc){
					getline(utctprh,lineatm);
					stringstream satm(lineatm);
					satm >> iutc >> E >> S38;
					continue;
				}
				else{break;}
			}			
		}

		eventdata.close();
		utctprh.close();
		outfile.close();
	}

	else cout << "Unable to open file"; 
	return 0;
}

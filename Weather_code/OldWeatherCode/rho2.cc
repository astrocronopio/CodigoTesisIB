/*
*	Toma archivo utctprh y anexa columna con densidad media calculada +-12 horas
* 
*/
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main(int argc, char** argv)
{
	string line;
	ifstream infile ("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat");
	ofstream outfile ("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_rho_2.dat");
	//ifstream infile ("utctprhInfilldr_010108_170815.dat");
	//ofstream outfile ("utctprhInfilldrc_010108_170815.dat");
	//ifstream infile ("/mnt/Datos/oscar/Trabajo/weather/inputs/utctprhdr_manualhBP.dat");
	//ofstream outfile ("/mnt/Datos/oscar/Trabajo/weather/inputs/utctprhdrc_manualhBP.dat");
	const int nb=24;
	float pe=0.0;
	float pa=0.0;
	int utc,ib,iw;
	double t,p,rho,rhod,h5,h6;
	double rho2[nb];
	int i = 0;
	int counter=0;
	int j;
	if(infile.is_open())
	{
		while(!infile.eof())
		{
			getline(infile,line);
			
			stringstream liness(line);
			
			if (i > 23 ) i=0;
			
			liness >> utc >> t >> p >> rho >> rhod >> h5 >> h6 >> iw >> ib;
			
			if(counter > 23) { outfile << utc << "\t" << t  << "\t" << p  << "\t" << rho  << "\t" << rhod  << "\t" << h5  << "\t" << h6  << "\t" << iw  << "\t" << ib<< "\t" <<rho2[i]<< endl;	}
			
			rho2[i]=rho;

			i++;
			counter++;
		}
	}
	else cout << "Unable to open file"; 
}

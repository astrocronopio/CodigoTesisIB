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
	ifstream infile ("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_rho_2.dat");
	ofstream outfile ("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_delay.dat");
	//ifstream infile ("utctprhInfilldr_010108_170815.dat");
	//ofstream outfile ("utctprhInfilldrc_010108_170815.dat");
	//ifstream infile ("/mnt/Datos/oscar/Trabajo/weather/inputs/utctprhdr_manualhBP.dat");
	//ofstream outfile ("/mnt/Datos/oscar/Trabajo/weather/inputs/utctprhdrc_manualhBP.dat");
	const int nb=288;
	float pe=0.0;
	float pa=0.0;
	int utc[nb],ib[nb],iw[nb];
	double t[nb],p[nb],rho[nb],rhod[nb],h5[nb],h6[nb],rho2[nb];
	int i = 0;
	int j;
	if(infile.is_open())
	{
		while(!infile.eof())
		{
			getline(infile,line);
			stringstream liness(line);
			j = i%288;
			liness >> utc[j] >> t[j] >> p[j] >> rho[j] >> rhod[j] >> h5[j] >> h6[j] >> iw[j] >> ib[j] >> rho2[j];
			//liness >> utc[j] >> t[j] >> p[j] >> rho[j] >> rhod[j] >> h6[j] >> iw[j] >> ib[j] >> rho2[j];
			if(i >= 143){
				if(j>=143){
					outfile << utc[j-143] << " " << t[j-143]  << " " << p[j-143]  << " " << rho[j-143]  << " " << rhod[j-143]  << " " << h5[j-143]  << " " << h6[j-143]  << " " << iw[j-143]  << " " << ib[j-143]<< " " <<rho2[j-143]<<" "<<rhod[j]<< endl;
					//outfile << utc[j-143] << " " << t[j-143]  << " " << p[j-143]  << " " << rho[j-143]  << " " << rhod[j]  << " " << h6[j-143]  << " " << iw[j-143]  << " " << ib[j-143]<< " " <<rho2[j-143]<< endl;
				}
				else{
					outfile << utc[j+145] << " " << t[j+145]  << " " << p[j+145]  << " " << rho[j+145]  << " " << rhod[j+145]  << " " << h5[j+145]  << " " << h6[j+145]  << " " << iw[j+145]  << " " << ib[j+145]<< " " <<rho2[j+145]<<" "<<rhod[j]<< endl;
					//outfile << utc[j+145] << " " << t[j+145]  << " " << p[j+145]  << " " << rho[j+145]  << " " << rhod[j]  << " " << h6[j+145]  << " " << iw[j+145]  << " " << ib[j+145]<< " " <<rho2[j+145]<< endl;
				}	
			}
			i++;
		}
	}
	else cout << "Unable to open file"; 
}

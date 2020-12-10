
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>

void East_West(
   int  bin,
   double aew,
   double bew,
   double avgst,
   double avgcd,
   int  nval,
   int ifrec,
   long  utci,
   long  utcf,
   double zmin,
   double zmax,
   int   is5t5,
   int   bine)
{

    long binid,UTC,t5,utc0;
    double Dec,Ra,Ra0,energy,DeltaNHexaAtRa,Theta,Phi,c,d;
   
    long iutcref = 1104537600;   //!1/1/2005;
    utc0 = 1072915200;
    nval=0;
    int ne=0;
    int nw=0;
    aew = 0.;
    bew = 0.;
    avgst = 0.;
    avgcd = 0.;

   double s1000, s1000_w, s38, energy_raw, energy_cor,ftr;
	double AugId,Eraw,Ecor;


   const char*  in_file = "pepe.dat";
	std::ifstream myfile (in_file);
   std::string line;

	//std::vector<long double> dnhex(interval);
	//exposure_weight(dnhex, utci, utcf, *freq);

	if(myfile.is_open())
	{
		while (!myfile.eof() ){			
			getline(myfile,line);			
			std::stringstream liness(line);			
			liness>>AugId>>Dec>>Ra>>Eraw>>Ecor>>UTC>>Theta>>Phi>>t5>>ftr;

         if(UTC < utci || UTC> utcf) continue; 
         if(Theta<zmin||Theta>zmax)continue; 
         if(is5t5 == 0  && t5==5) continue; 

         energy=Ecor;

      }
   }
}

void dipoloEW( double freq,
               double utci_opt,
               double utcf,
               double zmin_opt,
               double zmax,
               double id5t5_opt,
               int bine)

{
 return;
}

int main(int argc, char const *argv[])
{
   /* code */
   return 0;
}

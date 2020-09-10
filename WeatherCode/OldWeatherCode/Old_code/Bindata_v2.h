#ifndef __Bindata_H
#define __Bindata_H

#include <vector>

using namespace std;

class TypeBinData{
public:
	vector<int>    utcBinCenter;
	vector<int>    nevents;
	vector<double> binPres;
	vector<double> binDen;
	vector<double> binADen;
	vector<double> binHex6;
	vector<double> expevents;
};

/// class to bin data and calculate average weather info for each bin

class Bindata: public TypeBinData
{
	public:
	
		Bindata(
			int utcmin,			  //initial utc for analysis
			int utcmax,			  //final utc for analysis
			int binw,			  //bin width, usually 
			vector<int> 	utcw, //utc from weather file
			vector<int> 	utcev,//utc from event file
			vector<double> 	pres, //pressure
			vector<double> 	rho,  //density
			vector<double> 	rhod, //delay density
			vector<double> 	h6);  //6T5 hexagons
		
		~Bindata();
		
		/// Get binned data
		TypeBinData* GetData(bool isExp, bool isMainArray);
		
		/// Get the number of bins
		int GetNBins();
		
		/// Fill vector with expected events from ML fit
		void SetExpFit(vector<int> utcexpev,vector<double> expev);
		
		/// Set new bin Width (automatically sets the new number of bins)
		void SetBinWidth(int binw);

	private:
		int futcmin;
		int futcmax;
		int fbinw,fnbin;
		vector<int> futcw;
		vector<int> futcev;
		vector<int> futcexpev;
		vector<double> fpres;
		vector<double> frho;
		vector<double> frhod;
		vector<double> fh6;
		vector<double> fexpev;
};

#endif

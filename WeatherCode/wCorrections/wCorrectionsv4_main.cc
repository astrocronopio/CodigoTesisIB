/*=======================================================================================================
				v3 changes:
----> Include function isoutlier

==========================================================================================================*/
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <TMath.h>
#include "Bindatav1.h"
#include "MLFitv6.h"

using namespace std;

std::string file_utctprh = "/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_delay.dat";


bool isoutlier(int utc)
{
	int utcouti[] = {1276560000,1302307200,1308873600,1319328000};
	int utcoutf[] = {1276646400,1302480000,1309046400,1319500800};
	int no = 4;
	bool isout=false;
	for (int i=0; i<no; i++){
		if(utc < utcouti[i])return isout;
		if(utc < utcoutf[i]){
			isout = true;
			return isout;
		}
	}
	return isout;
}


void read_from_utctprh(	vector<int>*	utc_utctprh	,	vector<double>* pressure	, 
						vector<double>*	density		,	vector<double>* average_density	, 
						vector<double>* hex6		,	vector<double>* theta)
{	
	float t,p,rho,rhod,h6,h5,rho_old,rhod12;
	int utc, iw, ib;
	std::string line;

	///======== Read weather and hexagons data from utctprh file =============//

	std::cout<<"\n\nReading weather and hexagons data from utctprh file... \n\n";
	
	ifstream infileatm (file_utctprh);

	if(infileatm.is_open())
	{    
		while (!infileatm.eof() )
		{			
			getline(infileatm,line);			
			stringstream liness(line);			
			liness >> utc >> t >> p >> rho_old >> rhod >> h6 >> h5 >> iw >> ib >> rho >> rhod12;
			
			if(iw > 2 || ib==0) h6=0.;
			if(isoutlier(utc) || isoutlier(utc-300))h6=0.;
			
			utc_utctprh->push_back(utc);
			pressure->push_back(p);
			density->push_back(rho);
			average_density->push_back(rhod12);
			hex6->push_back(h6);			
		}
	}

	else cout << "Unable to open file";
}

///Reading from the herald file. It could be Infill or Main Array
void read_from_event_file(	std::string path_event_file	, float E_th, int binsec, 
							vector<int>* utc_event		, vector<double>* theta)
{	std::string line;

	double low_limit = (binsec-1)*0.15;
	double high_limit = binsec*0.15;

	int utc;
	double the, energy, p, rho, rhod, iw, sect;
	double augid,sdid, phi, dec, ra, s1000, ds1000;

	std::cout << "\n\nFile "<< path_event_file <<"\n\n"<< endl;
	ifstream infiledata (path_event_file);	/// Herald

	if(infiledata.is_open())
	{    
		while (!infiledata.eof() ){			
			getline(infiledata,line);
			stringstream liness(line);
		//For S38 analysis
			//liness >> utc >> the >> s38 >> energy >> p >> rho >> rhod >> iw;
		
		//Normal Analysis
			liness >> utc >> the >> energy >> p >> rho >> rhod >> iw;			/// herald

		//For PC data
			//liness >> augid >> sdid >> utc >> phi >> the >> dec >> ra >> s1000 >> ds1000 >> energy >> p >> rho >> rhod >> iw;		/// herald
		

			if(binsec != 0)
			{
				double sect = sin(the*TMath::Pi()/180.0)*sin(the*TMath::Pi()/180.0);
				if(sect<low_limit || sect>high_limit) continue;
			}
			if(energy<E_th) continue;

			if(iw <= 2 ){	
				utc_event->push_back(utc);
				theta->push_back(the);
			}
		}
	}
	else std::cout << "Unable to open file "<< path_event_file;
}

int main(int argc, char** argv)
//void wCorrections()
{
	int binsec=0;
	double E_th;

	if(argc == 8){ //All Data Set!
		binsec = 0;
		E_th = 0;
	}
	else if(argc == 9){// Now this the threshold
		binsec = 0;
		E_th = atoi(argv[1]);
	}
	else if(argc == 10){	 // 
		binsec = atoi(argv[2]);
		E_th = atof(argv[1]);
	}
	else{
		cout << "Uso: ./wCorrectionsv3_main E_threshold sec_bin" << endl;
		return 0;
	}

	if(binsec<0 || binsec>5){
		cout << "Parameter must be between 0 and 5" << endl;
		return 0;
	}

	std::cout<<E_th<<std::endl;

	//given sin^2(theta) bin value limits
	double low_limit = (binsec-1)*0.15;
	double high_limit = binsec*0.15;

	//Variables
	vector<double> pressure,density,average_density,hex6,theta;
	vector<int> utc_utctprh,utc_event;
	int utc;
	int iw,ib,j,n,sdid;
	long int augid;
	float t,p,rho,rhod,h6,h5,the,phi,energy,rho_old,ra,s1000,ds1000,dec,rhod12, s38;
	float Stot,Eraw,ntanks,raz,dthe,dphi,dene,l,b;

	///======== Read weather and hexagons data from utctprh file ===============================//
	
	read_from_utctprh(&utc_utctprh,&pressure,&density,&average_density,&hex6,&theta);

	///======== Read event data from file =====================================================//
	
	std::string path_event_file 	= argv[1+(argc-8)];
	read_from_event_file(path_event_file,  E_th,binsec, &utc_event, &theta);

	///======== Assign output files =====================================================//

	std::string path_fit			= argv[2+(argc-8)];
	std::string path_hour_of_the_day= argv[3+(argc-8)];
	std::string path_hour_expected  = argv[4+(argc-8)];
	std::string path_rate_expected	= argv[5+(argc-8)];

	///=========== Bin data using the Bindata class (typically in 1 hour bins)================//
	char * pEnd;

	unsigned long utcmin =  strtoul(argv[6+(argc-8)], &pEnd, 0);
	unsigned long utcmax =  strtoul(argv[7+(argc-8)], &pEnd, 0);

	int binw = 3600; //This defines the bin width
	
	// This is a class variable instantiation
	Bindata Bin1hr(	utcmin		,utcmax,
					binw		,utc_utctprh,
					utc_event	,pressure	,
					density		,average_density, hex6);


	// This is the line where the binning is done
	bool isExp = 0;//given sin^2(theta) bin
	bool isMainArray=true;
	TypeBinData *dataBin1hr = Bin1hr.GetData(isExp);//, isMainArray);
	int nbin = Bin1hr.GetNBins();
	
	// Printing the binning onto a output file
	ofstream outfile(path_hour_expected);
	
	for(int i = 0;i < nbin; i++)
	{
		outfile << dataBin1hr->utcBinCenter[i]  << "\t";
		outfile << dataBin1hr->nevents[i] 		<< "\t";
		outfile << dataBin1hr->binPres[i] 		<< "\t";
		outfile << dataBin1hr->binDen[i] 		<< "\t";
		outfile << dataBin1hr->binADen[i] 		<< "\t";
		outfile << dataBin1hr->binHex6[i] 		<< endl;
	}	

	///====  Performs a Maximum Likelihood fit of event rate using the MLfit class =====//
					

	RunFit(*dataBin1hr, //Dataset in 1 hour intervals
			utcmin,		//Initial Time UTC
			utcmax,		//Final Time   UTC
			nbin);		//Number of bins in the data
			
	//Prints the parameters onto the standard output

	TypeFitPars fitp = GetFitPars();

	std::cout << "------Energy Threshold: "<<E_th<<" EeV--------Bin: "<<binsec<<"----------" << endl;
	std::cout << "aP = " 	<< fitp.alphaP 	<< " +/- " << fitp.alphaP_err 	<< endl;
	std::cout << "arho = " 	<< fitp.alphaRho<< " +/- " << fitp.alphaRho_err << endl;
	std::cout << "brho = " 	<< fitp.betaRho << " +/- " << fitp.betaRho_err 	<< endl;
	std::cout << "lambda = "<< fitp.lambda 	<< " +/- " << fitp.lambda_err 	<< endl;
	std::cout << "Cinf = " 	<< fitp.cinf 	<< " +/- " << fitp.cinf_err 	<< endl;
	std::cout << "Chi2 = " 	<< fitp.chi2    << ", ndof = " << fitp.ndof 	<< endl;
	std::cout << "\n____________________\n";
	std::cout << "Chi2/ndof = " << fitp.redChi2 << endl;
	std::cout << "''''''''''''''''''''\n";

	if(binsec>=1)
	{
		ofstream file;

		if (binsec==1) file.open(path_fit);
		else file.open(path_fit,ios::app); /// 'app' is an option to 'app'end to the file (no rewrite)		

		double sect = (low_limit+high_limit)/2;
		double B = 1.073;
		double pf = B*(3.29-1);

		file << sect << "\t" ;
		file << fitp.alphaP   << "\t" << fitp.alphaP_err  	<< "\t";
		file << fitp.alphaRho << "\t" << fitp.alphaRho_err  << "\t";
		file << fitp.betaRho  << "\t" << fitp.betaRho_err 	<< "\t";
		file << fitp.redChi2  << endl;
		return 0;
	}

	///=========== writes ASCII file with data fitted================//
	
	TypeBinData fitData;
	GetExpev(&fitData);
	int 	nev[24] = { };
	double nexp[24] = { };
	double h6hr[24] = { };	
	double counter[24] = {0};
	
	nbin = (int)fitData.utcBinCenter.size();
	
	ofstream outfile2(path_hour_expected);
	
	for(int i = 0; i < nbin; i++)
	{		
		outfile2 << fitData.utcBinCenter[i] << "\t";
		outfile2 << fitData.nevents[i] 		<< "\t";
		outfile2 << fitData.expevents[i] 	<< "\t";
		outfile2 << fitData.binHex6[i] 		<< endl;

		int hr    = (int(fitData.utcBinCenter[i]/3600))%24;	/// hour of day for current bin
		counter[hr]+=1.0;
		nev[hr]  += fitData.nevents[i];						/// sum number of events,
		nexp[hr] += fitData.expevents[i];					/// expected events and
		h6hr[hr] += fitData.binHex6[i];						/// active hexagons for each hour of day		
	}
	///======== writes ASCII file with data for each hour of day ==========================//

	ofstream outfile3(path_hour_of_the_day);

		for(int j=0;j< 24;j++)
		{	
			outfile3 << j << "\t";
			outfile3 << nexp[j] << "\t";
			outfile3 << nev[j]  << "\t";
			outfile3 << h6hr[j] << "\t"<< counter[j] <<endl;
		}

	Bin1hr.SetExpFit(fitData.utcBinCenter, fitData.expevents);
	Bin1hr.SetBinWidth(86400); /// set one day bins for printing!
	
	TypeBinData *dataBin1day = Bin1hr.GetData(1);
	ofstream outfile4(path_rate_expected); 
	
	if(dataBin1day!=NULL)
	{
		nbin = Bin1hr.GetNBins();
		for(int i = 0;i < nbin; i++)
		{
			outfile4 << dataBin1day->utcBinCenter[i]<< "\t";
			outfile4 << dataBin1day->nevents[i] 	<< "\t";
			outfile4 << dataBin1day->expevents[i] 	<< "\t";
			outfile4 << dataBin1day->binHex6[i] 	<< endl;
		}
	}
	else std::cout << "Error ocurred!!!";

	return 0;

}
/*=======================================================================================================
				v3 changes:
----> Include function isoutlier

==========================================================================================================*/
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <TMath.h>
//#include "Bindata.cc"
//#include "MLFit.cc"
#include "Bindatav1.h"
#include "MLFitv5.2.h"

using namespace std;

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

int main(int argc, char** argv)
//void wCorrections()
{
	int binsec;
	double E_th;
	if(argc == 1){
		binsec = 0;
		E_th = 0;
	}
	else if(argc == 2){
		binsec = 0;
		E_th = atoi(argv[1]);
	}
	else if(argc == 3){	
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
	//double ll = 1.0 + (binsec-1)*0.2;
	//double hl = 1.0 + binsec*0.2;
	double ll = 0.0 + (binsec-1)*0.15;
	double hl = 0.0 + binsec*0.15;
	/*double ll = 0.9 + (binsec-1)*0.2;
	double hl = 0.9 + binsec*0.2;
	if(binsec==1){ll=1.0;hl=1.1;}
	if(binsec==5){ll=1.7;hl=2.0;}*/
	
	vector<double> pres,den,avgden,hex6,pres2,theta;
	vector<int> iutc,iutc2;
	int utc;
	int iw,ib,j,n,sdid;
	long int augid;
	float t,p,rho,rhod,h6,h5,the,phi,energy,rho_old,ra,s1000,ds1000,dec,rhod12, s38;
	float Stot,Eraw,ntanks,raz,dthe,dphi,dene,l,b;
	string line;

///======== Read weather and hexagons data from utctprh file ===============================//
///

	ifstream infileatm ("/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_delay.dat");
	if(infileatm.is_open())
	{    
		while (!infileatm.eof() ){			
			getline(infileatm,line);			
			stringstream liness(line);			
			liness >> utc >> t >> p >> rho_old >> rhod >> h6 >> h5 >> iw >> ib >> rho >> rhod12;
			if(iw > 2 || ib==0)h6=0.;
			if(isoutlier(utc) || isoutlier(utc-300))h6=0.;
			iutc.push_back(utc);
			pres.push_back(p);
			den.push_back(rho);
			avgden.push_back(rhod12);
			hex6.push_back(h6);			
		}
	}
	else cout << "Unable to open file";

///======== Read event data from file =====================================================//
///
	string path 				= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_weather_s1000_s38_nobp_expected.dat";
	string path_fit				= "../Herald_S38_S1000_expected/expected_above_2EeV_all_sin2.dat";
	string path_hour_of_the_day	= "../Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat";  //
	string path_hour_expected   = "../Herald_S38_S1000_expected/expected_above_2EeV_rate_hour.dat";	 //
	string path_rate_expected	= "../Herald_S38_S1000_expected/expected_above_2EeV_rate_day.dat" ; //

	cout << "\n\nFile "<< path <<"\n\n"<< endl;
	ifstream infiledata (path);	/// Herald

	j=0;
	if(infiledata.is_open())
	{    
		while (!infiledata.eof() ){			
			getline(infiledata,line);
			stringstream liness(line);
		//For S38 analysis
			liness >> utc >> the >> s38 >> energy >> p >> rho >> rhod >> iw;
		
		//Normal Analysis
			//liness >> utc >> the >> energy >> p >> rho >> rhod >> iw;			/// herald

		//For PC data
			//liness >> augid >> sdid >> utc >> phi >> the >> dec >> ra >> s1000 >> ds1000 >> energy >> p >> rho >> rhod >> iw;		/// herald
		
			if(binsec != 0){
				double sect = sin(the*TMath::Pi()/180)*sin(the*TMath::Pi()/180);
				if(sect<ll || sect>hl) continue;
			}
			if(energy<E_th)continue;
			if(iw <= 2 ){	
				iutc2.push_back(utc);
				theta.push_back(the);
			}
		}
	}
	else cout << "Unable to open file "<< path;

///=========== Bin data using the Bindata class (typically in 1 hour bins)================//
///
	int utcmin = 1104537600;//1072915500;
	int utcmax = 1451347500;//1451606700;
	int binw = 3600;	
	Bindata Bin1hr(utcmin,utcmax,binw,iutc,iutc2,pres,den,avgden,hex6);

	TypeBinData *dataBin1hr = Bin1hr.GetData(0);
	
	int nbin = Bin1hr.GetNBins();
/////////////////////////////////////////////////////
	ofstream outfile(path_hour_expected);
/////////////////////////////////////////////////////
	
	for(int i = 0;i < nbin; i++)
	{
		outfile << dataBin1hr->utcBinCenter[i] << "\t" << dataBin1hr->nevents[i] << "\t" << dataBin1hr->binPres[i] << "\t" << dataBin1hr->binDen[i] << "\t" << dataBin1hr->binADen[i] << "\t" << dataBin1hr->binHex6[i] << endl;
	}		

///======= Performs a Maximum Likelihood fit of event rate using the MLfit class ================//
///
	RunFit(*dataBin1hr,1104537600,1451347200,1230768000,1325376000,nbin);	

	TypeFitPars fitp = GetFitPars();
	cout << "--------------------------------------------------------------" << endl;
	cout << "aP = " 	<< fitp.alphaP 	<< " +/- " << fitp.alphaP_err 	<< endl;
	cout << "arho = " 	<< fitp.alphaRho<< " +/- " << fitp.alphaRho_err << endl;
	cout << "brho = " 	<< fitp.betaRho << " +/- " << fitp.betaRho_err 	<< endl;
	cout << "lambda = " << fitp.lambda 	<< " +/- " << fitp.lambda_err 	<< endl;
	cout << "Cinf = " 	<< fitp.cinf 	<< " +/- " << fitp.cinf_err 	<< endl;

	cout << "Chi2 = " 	<< fitp.chi2 	<< ", ndof = " << fitp.ndof << ", chi2/ndof = " << fitp.redChi2 << endl;
	
	if(binsec!=0){
		ofstream file;
//////////////////////////////////////////////////////////////////////
		file.open(path_fit,ios::app); /// app is an option for append to the file (no rewrite)		
/////////////////////////////////////////////////////////////////////
		double sect = (ll+hl)/2;
		double pf = 1.023*(3.29-1);
		file << sect << "\t" << fitp.alphaP*pf << "\t" << fitp.alphaP_err*pf << "\t" << fitp.alphaRho*pf << "\t" << fitp.alphaRho_err*pf<< "\t" << fitp.betaRho*pf << "\t" << fitp.betaRho_err*pf <<"\t"<<  fitp.redChi2  << endl;
		return 0;
	}

///======== writes ASCII file with data fitted====================================================//
///
	TypeBinData fitData;
	GetExpev(&fitData);
	int nev[24] = { };
	double nexp[24] = { },h6hr[24] = { };	
	nbin = (int)fitData.utcBinCenter.size();
///////////////////////////////////////////////////////////////////////////
	ofstream outfile2(path_hour_expected);
//////////////////////////////////////////////////////////////////////////
	for(int i = 0;i < nbin; i++)
	{		
		outfile2 << fitData.utcBinCenter[i] << "\t" << fitData.expevents[i] << "\t" << fitData.nevents[i] << "\t" <<  sqrt(fitData.nevents[i]) << "\t" << fitData.binHex6[i] << endl;
		int hr = (int(fitData.utcBinCenter[i]/3600))%24;	/// hour of day for current bin
		nev[hr] += fitData.nevents[i];						/// sum number of events,
		nexp[hr] += fitData.expevents[i];					/// expected events and
		h6hr[hr] += fitData.binHex6[i];						/// active hexagons for each hour of day		
	}
///======== writes ASCII file with data for each hour of day =====================================//
/////////////////////////////////////////////////////////
	ofstream outfile3(path_hour_of_the_day);
////////////////////////////////////////////////////////
	for(int j=0;j<24;j++)
	{
		outfile3 << nexp[j] << "\t"<< nev[j]<< "\t"<< sqrt(nev[j]) << "\t" << h6hr[j] << endl;
	}

	Bin1hr.SetExpFit(fitData.utcBinCenter,fitData.expevents);
	Bin1hr.SetBinWidth(86400*2); /// set one day bins
	TypeBinData *dataBin1day = Bin1hr.GetData(1);
	ofstream outfile4(path_rate_expected);
	if(dataBin1day!=NULL){
		nbin = Bin1hr.GetNBins();
		for(int i = 0;i < nbin; i++)
		{
			outfile4 << dataBin1day->utcBinCenter[i] << "\t" << dataBin1day->nevents[i] << "\t" << dataBin1day->expevents[i] <<  "\t" << dataBin1day->binHex6[i] << endl;
		}
	}
	else cout << "Error ocurred!!!";

	return 0;

}
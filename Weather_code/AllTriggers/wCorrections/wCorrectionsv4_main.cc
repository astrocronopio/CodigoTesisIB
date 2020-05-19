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

	if(argc == 8){
		binsec = 0;
		E_th = 0;
	}
	else if(argc == 9){
		binsec = 0;
		E_th = atoi(argv[1]);
	}
	else if(argc == 10){	
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

	double ll = 0.0 + (binsec-1)*0.15;
	double hl = 0.0 + binsec*0.15;

	
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
	//ifstream infileatm ("/home/ponci/Desktop/TesisIB/Coronel/Weather_PC/Weather/Raw/utctprhdrc_010104_090516.dat");
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
	string path 				= argv[1+(argc-8)];//"/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1EeV_cutted_merged_nobp.dat";
	string path_fit				= argv[2+(argc-8)];//"../2019/weather_analysis/AllTriggers_S38_1EeV_all_sin2.dat";
	string path_hour_of_the_day	= argv[3+(argc-8)];//"../2019/weather_analysis/AllTriggers_S38_1EeV_hour_of_the_day.dat";  //
	string path_hour_expected   = argv[4+(argc-8)];//"../2019/weather_analysis/AllTriggers_S38_1EeV_rate_hour.dat";	 //
	string path_rate_expected	= argv[5+(argc-8)];//"../2019/weather_analysis/AllTriggers_S38_1EeV_rate_day.dat" ; //

	cout << "\n\nFile "<< path <<"\n\n"<< endl;
	ifstream infiledata (path);	/// Herald

	j=0;
	if(infiledata.is_open())
	{    
		while (!infiledata.eof() ){			
			getline(infiledata,line);
			stringstream liness(line);
		//For S38 analysis
			//liness >> utc >> the >> s38 >> energy >> p >> rho >> rhod >> iw;
		
		//Normal Analysis
			liness >> utc >> the >> energy >> p >> rho >> rhod >> iw;			/// herald

			if(binsec != 0){
				//double sect = 1./cos(the*TMath::Pi()/180);
				//if(sect<ll || sect>hl) continue;
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
	char * pEnd;

	unsigned long utcmin =  strtoul(argv[6+(argc-8)], &pEnd, 0); //1104537600; //1372699409 ;
	unsigned long utcmax =  strtoul(argv[7+(argc-8)], &pEnd, 0); //1577825634 ; //31 12 2019 00:00:00 //flag ? 1472688000 :  1544933508;

	//int utcmin = int(utci);//1388628499;//1372680308;
	//int utcmax = int(utcf);//1550490858;
	int binw = 3600;	
	Bindata Bin1hr(utcmin,utcmax,binw,iutc,iutc2,pres,den,avgden,hex6);

	TypeBinData *dataBin1hr = Bin1hr.GetData(0);
	
	int nbin = Bin1hr.GetNBins();
/////////////////////////////////////////////////////
	ofstream outfile(path_hour_expected);
/////////////////////////////////////////////////////
	
	for(int i = 0;i < nbin; i++)
	{	if (dataBin1hr->binHex6[i]>690)
		{
			outfile << dataBin1hr->utcBinCenter[i] << "\t" << dataBin1hr->nevents[i] << "\t" << dataBin1hr->binPres[i] << "\t" << dataBin1hr->binDen[i] << "\t" << dataBin1hr->binADen[i] << "\t" << dataBin1hr->binHex6[i] << endl;
		}
		
	}		

///======= Performs a Maximum Likelihood fit of event rate using the MLfit class ================//
///
	//					Inicio Fin			
	RunFit(*dataBin1hr,utcmin,utcmax,nbin);	///1451347200 1438387500 1420070400 1370044800 1388534400

	TypeFitPars fitp = GetFitPars();
	cout << "--------------------------------------------------------------" << endl;
	cout << "aP = " 	<< fitp.alphaP 	<< " +/- " << fitp.alphaP_err 	<< endl;
	cout << "arho = " 	<< fitp.alphaRho<< " +/- " << fitp.alphaRho_err << endl;
	cout << "brho = " 	<< fitp.betaRho << " +/- " << fitp.betaRho_err 	<< endl;
	cout << "lambda = " << fitp.lambda 	<< " +/- " << fitp.lambda_err 	<< endl;
	cout << "Cinf = " 	<< fitp.cinf 	<< " +/- " << fitp.cinf_err 	<< endl;

	cout << "Chi2 = " 	<< fitp.chi2 	<< ", ndof = " << fitp.ndof << ", chi2/ndof = " << fitp.redChi2 << endl;
	
	if(binsec>1){
		ofstream file;
//////////////////////////////////////////////////////////////////////
		file.open(path_fit,ios::app); /// app is an option for append to the file (no rewrite)		
/////////////////////////////////////////////////////////////////////
		double sect = (ll+hl)/2;
		double pf = 1.023*(3.29-1);
		//file << sect << "\t" << fitp.alphaP << "\t" << fitp.alphaP_err << "\t" << fitp.alphaRho << "\t" << fitp.alphaRho_err<< "\t" << fitp.betaRho << "\t" << fitp.betaRho_err << endl;
		file << sect << "\t" << fitp.alphaP*pf << "\t" << fitp.alphaP_err*pf << "\t" << fitp.alphaRho*pf << "\t" << fitp.alphaRho_err*pf<< "\t" << fitp.betaRho*pf << "\t" << fitp.betaRho_err*pf <<"\t"<<  fitp.redChi2  << endl;
		return 0;
	}
	else if (binsec==1)
	{
		ofstream file;
		file.open(path_fit);	
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
		outfile2 << fitData.utcBinCenter[i] << "\t" << fitData.nevents[i] << "\t" << fitData.expevents[i] << "\t" << fitData.binHex6[i] << endl;
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
	Bin1hr.SetBinWidth(86400); /// set one day bins
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
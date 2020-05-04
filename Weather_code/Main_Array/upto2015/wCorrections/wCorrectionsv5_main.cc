/*=======================================================================================================
				v5 changes:
----> Include function selectseas

==========================================================================================================*/
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <ctime>

#include <TMath.h>
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

/// Function that returns "0" if utc time is in winter (21 march to 21 sept)
/// and "1" if it is in summer (21 sept to 21 march)
int selectseas(int utc)
{	
	const time_t time = (time_t)utc;
	tm *gmtm = gmtime(&time);
	int mon = gmtm->tm_mon;		/// month of the UTC (0-11)
	int day = gmtm->tm_mday;	/// day of the UTC	(1-31)
	/// 
	if(mon < 2 || mon > 8) return 1;
	if(mon == 2 && day < 21) return 1;
	if(mon == 8 && day >= 21) return 1;
	return 0;
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

	double ll = 0.0 + (binsec-1)*0.15;
	double hl = 0.0 + binsec*0.15;
	
	vector<double> pres,den,avgden,hex6,pres2,theta;
	vector<int> iutc,iutc2;
	int utc;
	int iw,ib,j,n,sdid;
	long int augid;
	float t,p,rho,rhod,h6,h5,the,phi,energy,rho_old,ra,s1000,ds1000,dec,rhod12;
	float Stot,Eraw,ntanks,raz,dthe,dphi,dene,l,b;
	string line;

///======== Read weather and hexagons data from utctprh file ===============================//
///

	ifstream infileatm ("../../datos_auger/utctprhdrc_010104_090516.dat");
	
	if(infileatm.is_open())
	{    
		while (!infileatm.eof() ){			
			getline(infileatm,line);			
			stringstream liness(line);			
			//liness >> utc >> t >> p >> rho >> rhod >> h6 >> h5 >> iw >> ib;
			//liness >> utc >> t >> p >> rho_old >> rhod >> h6 >> h5 >> iw >> ib >> rho;
			liness >> utc >> t >> p >> rho_old >> rhod >> h6 >> h5 >> iw >> ib >> rho >> rhod12;
			if(iw > 2 || ib==0)h6=0.;
			//if(isoutlier(utc) || isoutlier(utc-300))h6=0.;
			if(selectseas(utc)==1)h6=0.;
			iutc.push_back(utc);
			pres.push_back(p);
			den.push_back(rho);
			//den.push_back(rho_old);
			//avgden.push_back(rhod);
			avgden.push_back(rhod12);
			hex6.push_back(h6);			
		}
	}
	else cout << "Unable to open file";

///======== Read event data from file =====================================================//
///
	ifstream infiledata ("../main_array/HeraldWeather060noBPdr6t5_110416.dat");	/// Herald

	j=0;
	if(infiledata.is_open())
	{    
		while (!infiledata.eof() ){			
			getline(infiledata,line);
			stringstream liness(line);
			liness >> augid >> sdid >> utc >> phi >> the >> dec >> ra >> s1000 >> ds1000 >> energy >> p >> rho >> rhod >> iw;		/// herald

			if(binsec != 0){

				double sect = sin(the*TMath::Pi()/180)*sin(the*TMath::Pi()/180);
				if(sect<ll || sect>hl) continue;
			}
			if(energy<E_th)continue;
			//if(ntanks!=6)continue;
			//if(the <= 60)continue;
			if(selectseas(utc)==1)continue;
			if(iw <= 2 ){
				iutc2.push_back(utc);
				theta.push_back(the);
			}
		}
	}
	else cout << "Unable to open file";

///=========== Bin data using the Bindata class (typically in 1 hour bins)================//
///
	int utcmin 	= 1072915500;
	int utcmax 	= 1451347500;
	int binw 	= 3600		;	

	Bindata Bin1hr(utcmin,utcmax,binw,iutc,iutc2,pres,den,avgden,hex6);
	TypeBinData *dataBin1hr = Bin1hr.GetData(0);
	int nbin = Bin1hr.GetNBins();
	ofstream outfile("../main_array/outfile1.dat");
	
	for(int i = 0;i < nbin; i++)
	{
		outfile << dataBin1hr->utcBinCenter[i] << " " << dataBin1hr->nevents[i] << " " << dataBin1hr->binPres[i] << " " << dataBin1hr->binDen[i] << " " << dataBin1hr->binADen[i] << " " << dataBin1hr->binHex6[i] << endl;
	}		

///======= Performs a Maximum Likelihood fit of event rate using the MLfit class ================//
///
	RunFit(*dataBin1hr,1104537600,1451347200,1230768000,1325376000,nbin);	

	TypeFitPars fitp = GetFitPars();
	cout << "--------------------------------------------------------------" << endl;
	cout << "aP = " << fitp.alphaP << " +/- " << fitp.alphaP_err << endl;
	cout << "arho = " << fitp.alphaRho << " +/- " << fitp.alphaRho_err << endl;
	cout << "brho = " << fitp.betaRho << " +/- " << fitp.betaRho_err << endl;
	cout << "lambda = " << fitp.lambda << " +/- " << fitp.lambda_err << endl;
	cout << "Cinf = " << fitp.cinf << " +/- " << fitp.cinf_err << endl;
	cout << "Chi2 = " << fitp.chi2 << ", ndof = " << fitp.ndof << ", chi2/ndof = " << fitp.redChi2 << endl;
	
	if(binsec!=0){
		ofstream file;
		file.open("../main_array/wcoefsvssin2a1_offline.dat",ios::app); /// app is an option for append to the file (no rewrite)		
		double sect = (ll+hl)/2;
		double pf = 1.023*(3.29-1);
		//file << sect << " " << fitp.alphaP << " " << fitp.alphaP_err << " " << fitp.alphaRho << " " << fitp.alphaRho_err<< " " << fitp.betaRho << " " << fitp.betaRho_err << endl;
		file << sect << " " << fitp.alphaP*pf << " " << fitp.alphaP_err*pf << " " << fitp.alphaRho*pf << " " << fitp.alphaRho_err*pf<< " " << fitp.betaRho*pf << " " << fitp.betaRho_err*pf << endl;
		return 0;
	}

///======== writes ASCII file with data fitted====================================================//
///
	TypeBinData fitData;
	GetExpev(&fitData);
	int nev[24] = { };
	double nexp[24] = { },h6hr[24] = { };	
	nbin = (int)fitData.utcBinCenter.size();
	ofstream outfile2("../main_array/outfile2.dat");
	for(int i = 0;i < nbin; i++)
	{		
		outfile2 << fitData.utcBinCenter[i] << " " << fitData.expevents[i] << " " << fitData.nevents[i] << " " <<  sqrt(fitData.nevents[i]) << " " << fitData.binHex6[i] << endl;
		int hr = (int(fitData.utcBinCenter[i]/3600))%24;	// hour of day for current bin
		nev[hr] += fitData.nevents[i];						// sum number of events,
		nexp[hr] += fitData.expevents[i];					// expected events and
		h6hr[hr] += fitData.binHex6[i];						// active hexagons for each hour of day
	}
///======== writes ASCII file with data for each hour of day =====================================//
///
	ofstream outfile3("../main_array/outfile3.dat");
	for(int j=0;j<24;j++)
	{
		outfile3 << nexp[j] << " "<< nev[j]<< " "<< sqrt(nev[j]) << " " << h6hr[j] << endl;
	}

	Bin1hr.SetExpFit(fitData.utcBinCenter,fitData.expevents);
	Bin1hr.SetBinWidth(86400*2); /// set one day bins
	TypeBinData *dataBin1day = Bin1hr.GetData(1);
	ofstream outfile4("../main_array/outfile4.dat");
	if(dataBin1day!=NULL){
		nbin = Bin1hr.GetNBins();
		for(int i = 0;i < nbin; i++)
		{
			outfile4 << dataBin1day->utcBinCenter[i] << " " << dataBin1day->nevents[i] << " " << dataBin1day->expevents[i] <<  " " << dataBin1day->binHex6[i] << endl;
		}
	}
	else cout << "Error ocurred!!!";

	return 0;

}

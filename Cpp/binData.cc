/*
* This Macro ROOT takes the Herald data set (Auger Observatory data) with wheather information of the place (Winfo) (Temperature, Pressure, 
* and $\rho$ (density) ). Also it creates files with the number of events corresponding to Winfo and Hexagons, in intervals of an hour and a day. 
* This code was originally modified by Oscar Taborda and modified for her BSc work by Evelyn Coronel @08.08.2019\\
* The Winfo file is unmodified, but in the Auger datafile a script removed data that should not be used.
*/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

//ROOT specific headers
#include "TCanvas.h" 
#include "TGraph.h"
#include "TGraphErrors.h"
#include "TProfile.h"
#include "TH1.h"
#include "TMath.h"

using namespace std;

const int nbins = 40000;

vector<double> 	 pres,den,avgden,hex6,pres2,theta,energy_utc, phi;
vector<double>   humidity_vector, humidity_rho_vector, humidity_av_rho_vector;//Global vectors with weather data
vector<long long int> iutc,iutc2; 	

int nev[24] = { }; //Number of events in a
double h6hr[24] = { }; 


//_______________________________________________________________________
void readFiles()
{	//Tags of the Winfo file (utctprh) according to http://auger.uis.edu.co/data/private.html

	int 		 iw, bad_period;					//iw: bad weather flag
	float 		 t,p,rho,av_rho,h6,h5; 				//temperature, pression, density, mean density in 24 hs, 6T6 and 5T5 hex
	float		 humidity, humidity_rho, humidity_av_rho; //According to Oscar Taborda, these are the data attached to the utctrh file

	//These are the tags on the Herald data set according to http://ipnwww.in2p3.fr/~augers/AugerProtected/herald.php

	long int 	 auger_id, stations;
	float		 Theta,Phi,l,b;
	long long int 	 utc,tcore;
	float		 XCore,YCore, S1000, dS1000, Ra, Dec, dTheta,dPhi, dXCore, dYCore;
	unsigned int Estimation, IsT5, IsT5p, IsT5pp, Fd_trigger;
	float 		 GeoFitChi2, LDFfitChi2, GlobfitChi2, GlobNdof, LDFB, LDFG, R, SdId, IsICR;
	float		 S1000_obs, energy, energy_backup,GPStime, Infill, FitBeta, S;
	unsigned int ntanks, ntanksCheck, PMTs, TanksFlag;
	int 		 bad_periodFlag;

	string line;
	int hr; //auxiliar

	//_______________This is the Winfo data set________________
	//ifstream infileatm ("utctprh.dat");
	ifstream infileatm ("/home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Weather/utctprh.dat");

	if(infileatm.is_open())
	{    
		while (!infileatm.eof() ){			
			getline(infileatm,line);	//gets a line from the Winfo data set		
			stringstream liness(line);			
			liness >> utc >> t >> p >> rho >> av_rho >> h6 >> h5 >> iw >> bad_period>>humidity>>humidity_rho>>humidity_av_rho;

			if(iw > 4 || bad_period==0)
			{	
				h6=0.;h5=0.;}  	//If bad_period==0, data is not used!
				iutc.push_back(utc);
				pres.push_back(p);
				den.push_back(rho);
				avgden.push_back(av_rho);
				hex6.push_back(h6);  
				/////
				humidity_vector.push_back(humidity);
				humidity_rho_vector.push_back(humidity_rho);
				humidity_av_rho_vector.push_back(humidity_av_rho);					// 6T5
				//hex6.push_back(h6 + 3/2*(h5-h6));  	// 5T5 + 6T5

			//if(utc>=1496275200 && utc<1498867200)
			//{
				hr = (int(utc/3600))%24;				// hour of day for current bin
				h6hr[hr] += h6;							///active 6T5 hexagons for each hour of day
				//h6hr[hr] += h6 + 3/2*(h5-h6);			///active 6T5 + 5T5 hexagons for each hour 
			//}
				
		}
	}
	else cout << "Unable to open file from the Weather Information!";
	
	//_______This is the Auger data set, from the Herald_______(I removed obselet data)
	//ifstream infiledata ("Archive_v6r2p2.dat");
	ifstream infiledata ("/home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Herald/Central/Modified/Herald_simple_modified.dat");

	if(infiledata.is_open())
	{    
		while (!infiledata.eof() ){			
			getline(infiledata,line);
			stringstream liness(line);	

		//	liness		>>	auger_id 	>>	stations		>>	Theta		>>	Phi 			>>	l 			>>	b ;
		//	liness		>>	utc 		>>	tcore			>>	XCore 		>>	YCore 			>>	S1000 		>>	dS1000;
		//	liness		>>	Ra 			>>	Dec 			>>	dTheta 		>>	dPhi 			>>	dXCore 		>>	dYCore;
		//	liness		>>	Estimation	>>	IsT5			>>	IsT5p		>>	IsT5pp			>>	Fd_trigger	>>	GeoFitChi2;
		//	liness		>>	LDFfitChi2	>>	GlobfitChi2		>>	GlobNdof	>>	LDFB			>>	LDFG		>>	R 			>>	SdId;
		//	liness		>>	IsICR		>>	S1000_obs		>>	energy		>>	energy_backup	>> 	GPStime		>>	Infill		>>	FitBeta;
		//	liness		>>	ntanks 		>>	ntanksCheck		>>	PMTs		>>	TanksFlag		>>	S 			>>	bad_periodFlag;



		liness >> utc >> Theta >> Phi >>  S1000 >> dS1000 >> Ra >> Dec >> energy;

			//if(Theta <= 60 && energy >= 2.0 && ntanks > 5)
		//if(Theta <= 60 && energy >= 2.0)
			//{
				iutc2.push_back(utc);
				energy_utc.push_back(energy);
				theta.push_back(Theta);
				phi.push_back(Phi);

				
				//if(utc>=1496275200 && utc<1498867200)
				//{
					hr = (int(utc/3600))%24;
					//cout<<hr<<endl;			///hour of day for current event
					nev[hr]++;					///sum number of events
				//}
			//}
		}
	}
	else cout << "Unable to open file of the Auger Data!";
}

//______________________________________________________________________________
void binData()
{
	// data input  		
	readFiles();	

	//This part creates histograms of the data (I will re-do them asap in pyROOT)
	
	long int utcmin = 1072915500; ///minimum lower limit, default 01-01-2004
	long int utcmax = 1545604800;// When the weather seemed wrong
	int binw = 3600*24;			 // Choosing if the data will be analized daily, monthly, hourly, yearly
	int nhr = (utcmax - utcmin)/binw;

		//Histogram of weather data
		TProfile *hprof_p  		= new TProfile("hprof_p"		,"Pressure profile"		,nhr,utcmin,utcmax);
		TProfile *hprof_rho  	= new TProfile("hprof_rho"		,"Density profile"		,nhr,utcmin,utcmax);
		TProfile *hprof_av_rho 	= new TProfile("hprof_av_rho"	,"Mean density profile"	,nhr,utcmin,utcmax);
		TProfile *hprof_hex  	= new TProfile("hprof_hex"		,"Hexagons profile"		,nhr,utcmin,utcmax);	

		//hprof_p		->Draw(); 		
		//hprof_rho  	->Draw();
		//hprof_av_rho->Draw();	
		//hprof_hex	->Draw(); 	

		TH1I *hev  = new TH1I("hev","event histogram",nhr,utcmin-300,utcmax-300);
	
	vector<int>::size_type nb = iutc.size();
	
	for ( unsigned i = 0; i < nb; i++) 
	{
		hprof_p->		Fill(iutc[i],pres[i]);
		hprof_rho->		Fill(iutc[i],den[i]);
		hprof_av_rho->	Fill(iutc[i],avgden[i]);
		hprof_hex->		Fill(iutc[i],hex6[i]);		
	}

	ofstream outfile4("energy_utc_theta_phi.dat");
	
	nb = iutc2.size();	
	for (unsigned i = 0; i < nb; i++) 
	{
		//double st = 1./cos(theta[i]*TMath::Pi()/180);
		//if(st>1.8 && st<2.0)hev->Fill(iutc2[i]);
		hev->Fill(iutc2[i]);
		outfile4<< iutc2[i] << "\t"<< energy_utc[i]<<"\t"<< theta[i]<< "\t"<<phi[i] <<endl;
	}
	//_________________________________________________________
	//Printing data on files 


	ofstream outfile("utctprh_filtered_by_bad_period.dat");
	
	for(int j=1; j<=nhr; j++)
	{
		TAxis *xaxis 	= hev->GetXaxis();
		Double_t utcref = xaxis->GetBinCenter(j);
		outfile << (long int)utcref << " ";
		outfile << hev->GetBinContent(j) << " " ;
		outfile << hprof_p->GetBinContent(j) << " " << hprof_rho->GetBinContent(j)<< " "<< hprof_av_rho->GetBinContent(j) << " ";
		outfile << hprof_hex->GetBinContent(j) << endl;			
	}
	outfile.close();

	
	ofstream outfile2("histogram_hourly_of_events.dat");
	
	for(int j=0; j < 24; j++)
	{
		outfile2 << j <<"	"<<nev[j] << " " << h6hr[j] << endl;
		//cout << nev[j] <<endl;
	}
	outfile2.close();

	//___________________________________
	/*
	ofstream outfile3("Herald060noBPa1-bind_wca1.dat");
	TProfile *hprofh2 	= (TProfile *)  hprof_hex->Rebin(24,"hprofh2");
	TH1I 	 *hev2 		= (TH1I *)		hev->Rebin(24,"hev2");
	//TH1D *hr = (TH1D*)hev->Rebin(24,"hr");
	int ndays = hev2->GetNbinsX();
	//cout << ndays << endl;
	
	for(int j=1; j<=ndays; j++)
	{
		if(hprofh2->GetBinContent(j) == 0) continue;
		Double_t rate 		= hev2->GetBinContent(j)/hprofh2->GetBinContent(j);
		Double_t rate_err 	= sqrt(hev2->GetBinContent(j))/hprofh2->GetBinContent(j);
		//hr->SetBinContent(j,rate);
		outfile2 << (long int)hev2->GetBinCenter(j)<< " " << hev2->GetBinContent(j) << " " << hprofh2->GetBinContent(j) << " " << rate << " " << rate_err << endl;
	}	
	hev2->Draw();*/
}

#ifndef __CINT__
int main() 
{
	binData();
	return 0;
}
#endif
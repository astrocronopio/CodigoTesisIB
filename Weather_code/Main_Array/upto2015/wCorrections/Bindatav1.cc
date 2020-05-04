/*=======================================================================================================
				v1 changes:
----> Remove hexagons and events from periods with low exposure
==========================================================================================================*/
#include "Bindatav1.h"

#include "TProfile.h"
#include "TH1.h"

#include <vector>
#include <iostream>

using namespace std;

Bindata::Bindata(int utcmin,int utcmax,int binw,
		vector<int> utcw,vector<int> utcev,
		vector<double> pres,vector<double> rho,vector<double> rhod,
		vector<double> h6) :
	futcmin(utcmin),
	futcmax(utcmax),
	fbinw(binw),
	futcw(utcw),
	futcev(utcev),
	fpres(pres),
	frho(rho),
	frhod(rhod),
	fh6(h6)
{
	fnbin = (futcmax - futcmin)/fbinw;
}

Bindata::~Bindata(){};

TypeBinData* Bindata::GetData(bool isExp)
{
	TProfile *hprofp  	= new TProfile("hprofp","pressure profile",fnbin,futcmin,futcmax);
	TProfile *hprofd  	= new TProfile("hprofd","density profile",fnbin,futcmin,futcmax);
	TProfile *hprofad 	= new TProfile("hprofad","mean density profile",fnbin,futcmin,futcmax);
	TProfile *hprofh  	= new TProfile("hprofh","hexagons profile",fnbin,futcmin,futcmax);	
	TH1I 	 *hev  		= new TH1I("hev","event histogram",fnbin,futcmin-300,futcmax-300);
	TProfile *hprofeev  = new TProfile("hprofeev","expected events profile",fnbin,futcmin,futcmax);

	vector<int>::size_type nb = futcw.size();
	
	for ( unsigned i = 0; i < nb; i++) {
		hprofp->Fill(futcw[i],fpres[i]);
		hprofd->Fill(futcw[i],frho[i]);
		hprofad->Fill(futcw[i],frhod[i]);
		hprofh->Fill(futcw[i],fh6[i]);		
	}
	
	nb = futcev.size();	
	for ( unsigned i = 0; i < nb; i++) {
		hev->Fill(futcev[i]);
	}
	
	if(isExp){
	if(!futcexpev.empty() && !fexpev.empty()){		
		nb = futcexpev.size();
		for ( unsigned i = 0; i < nb; i++) {
			hprofeev->Fill(futcexpev[i],fexpev[i]);
		}
	}
	else return NULL;
	}
	
	TypeBinData *outData = new TypeBinData();
	for(int j = 1; j <= fnbin; j++){
		TAxis *xaxis = hev->GetXaxis();
		double utcref = xaxis->GetBinCenter(j);
		outData->utcBinCenter.push_back((int)utcref);
		outData->nevents.push_back((int)hev->GetBinContent(j));
		outData->binPres.push_back(hprofp->GetBinContent(j));
		outData->binDen.push_back(hprofd->GetBinContent(j));
		outData->binADen.push_back(hprofad->GetBinContent(j));
		if(hprofh->GetBinContent(j)>5)outData->binHex6.push_back(hprofh->GetBinContent(j)); 	///Infill
		//if(hprofh->GetBinContent(j)>515)outData->binHex6.push_back(hprofh->GetBinContent(j));	/// MA
		else outData->binHex6.push_back(0);
		if(isExp)outData->expevents.push_back(hprofeev->GetBinContent(j)*hprofeev->GetBinEntries(j));
	}
	
	hprofp->Delete();
	hprofd->Delete();
	hprofad->Delete();
	hprofh->Delete();	
	hev->Delete();
	hprofeev->Delete();
	return outData;
}

int Bindata::GetNBins()
{
	return fnbin;
}

void Bindata::SetExpFit(vector<int> utcexpev,vector<double> expev)
{	
	futcexpev = utcexpev;
	fexpev = expev;
}

void Bindata::SetBinWidth(int binw){
	fbinw = binw;
	fnbin = (futcmax - futcmin)/fbinw;
}

/*=======================================================================================================
 * 			v5.2 changes:
 * ----> New free parameter "Cinf" added
 
==========================================================================================================*/
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "TMinuit.h"

#include "Bindatav1.h"
#include "MLFitv5.2.h"


/*TypeBinData fbinData;
int futcmin;
int futcmax;
int fnbins;
double fpars[4];
double ferrors[4];*/

double logfact(int N){
	int i;
	double logf = 0.;
	if(N > 1){
		for (i = 2; i <= N; i++){
			logf += log((double) i);
			}
		}
	return logf;
}
//______________________________________________________________________________
/// input function for minuit 
void fcn(int &npar, double *gin, double &f, double *par, int iflag)
{
/// calculate log Likelihood
	int j;
   double flogL = 0.;
   int isumn = 0;
   double sumhex = 0.;
   double ti,t0,tf,C,R0,mu,ee;
   t0 = (futcsdec-futcmin)/(365.25*24*3600);// start time of rate decay
   tf = (futcedec-futcmin)/(365.25*24*3600);// end time of rate decay
///	calculate R0: average rate we would have observed if the atmospheric 
///	parameters were always the reference ones
	for (j = 0; j < fnbins; j++) {
			//if(fbinData.nevents[j]==0)continue;
			if(fbinData.utcBinCenter[j] > futcmax || fbinData.utcBinCenter[j] < futcmin) continue;
			isumn += fbinData.nevents[j];
			C=1.+par[0]*(fbinData.binPres[j]-kP0)+par[1]*(fbinData.binADen[j]-krho0)+par[2]*
     			(fbinData.binDen[j]-fbinData.binADen[j]);
			ti=(fbinData.utcBinCenter[j]-futcmin)/(365.25*24*3600);
			ee = 1.0;
			if(ti > t0)ee = (1.-par[4])*exp(-par[3]*(ti-t0))+par[4];/// factor to take into account the global rate decrease
			sumhex += fbinData.binHex6[j]*C*ee;
	}
		R0 = isumn/sumhex;
	for (j = 0; j < fnbins; j++) {
			//if(fbinData.nevents[j]==0)continue;
			if(fbinData.utcBinCenter[j] > futcmax || fbinData.utcBinCenter[j] < futcmin) continue;
			C=1.+par[0]*(fbinData.binPres[j]-kP0)+par[1]*(fbinData.binADen[j]-krho0)+par[2]*
     			(fbinData.binDen[j]-fbinData.binADen[j]);
			ti=(fbinData.utcBinCenter[j]-futcmin)/(365.25*24*3600);
			ee = 1.0;
			if(ti > t0)ee = (1.-par[4])*exp(-par[3]*(ti-t0))+par[4];
			mu = R0*fbinData.binHex6[j]*C*ee;
			if(mu == 0.0) continue;
			flogL -= 2*( fbinData.nevents[j]*log(mu)-mu-logfact(fbinData.nevents[j]));
   }
   f = flogL;
}

//______________________________________________________________________________
void fcn2(double *par,double *pchi2,int *pndof,TypeBinData *fitData)
{
/// calculate log Likelihood
	int j;
	double flogL = 0.;
	int isumn = 0;
	double sumhex = 0.;
	double ti,t0,tf,C,R0,mu,ee,chi2;
	int ndof;
	chi2 = 0.;
	ndof = 0;
	t0 = (futcsdec-futcmin)/(365.25*24*3600);// start time of rate decay
	tf = (futcedec-futcmin)/(365.25*24*3600);// end time of rate decay
///	calculate R0: average rate we would have observed if the atmospheric 
///	parameters were always the reference ones
	for (j = 0; j < fnbins; j++) {
			//if(fbinData.nevents[j]==0)continue;
		if(fbinData.utcBinCenter[j] > futcmax || fbinData.utcBinCenter[j] < futcmin) continue;
		isumn += fbinData.nevents[j];
		C=1.+par[0]*(fbinData.binPres[j]-kP0)+par[1]*(fbinData.binADen[j]-krho0)+par[2]*
     		(fbinData.binDen[j]-fbinData.binADen[j]);
		ti=(fbinData.utcBinCenter[j]-futcmin)/(365.25*24*3600);		
		ee = 1.0;
		if(ti > t0)ee = (1.-par[4])*exp(-par[3]*(ti-t0))+par[4];
		sumhex += fbinData.binHex6[j]*C*ee;
	}
	R0 = isumn/sumhex;
	for (j = 0; j < fnbins; j++) {
		//if(fbinData.nevents[j]==0)continue;
		if(fbinData.utcBinCenter[j] > futcmax || fbinData.utcBinCenter[j] < futcmin) continue;
		C=1.+par[0]*(fbinData.binPres[j]-kP0)+par[1]*(fbinData.binADen[j]-krho0)+par[2]*
    		(fbinData.binDen[j]-fbinData.binADen[j]);
		ti=(fbinData.utcBinCenter[j]-futcmin)/(365.25*24*3600);
		ee = 1.0;
		if(ti > t0)ee = (1.-par[4])*exp(-par[3]*(ti-t0))+par[4];
		mu = R0*fbinData.binHex6[j]*C*ee;
		if(mu == 0.0) continue;
		flogL -= 2*( fbinData.nevents[j]*log(mu)-mu-logfact(fbinData.nevents[j]));
		ndof++;
		chi2 += ((double)fbinData.nevents[j]-mu)*((double)fbinData.nevents[j]-mu)/mu;
		if(fitData!=NULL){
			fitData->utcBinCenter.push_back(fbinData.utcBinCenter[j]);
			fitData->expevents.push_back(mu);
			fitData->nevents.push_back(fbinData.nevents[j]);
			fitData->binHex6.push_back(fbinData.binHex6[j]);
		}
	}
   *pchi2 = chi2;
   *pndof = ndof;
}

void RunFit(TypeBinData binData,int utcmin,int utcmax,int utcsdec,int utcedec,int nbins)
{
	fbinData = binData;
	futcmin = utcmin;
	futcmax = utcmax;
	futcsdec = utcsdec;
	futcedec = utcedec;
	fnbins = nbins;
	TMinuit *gMinuit = new TMinuit(4);  ///initialize TMinuit with a maximum of 4 params	
	gMinuit->SetFCN(fcn);	/// Set the function to be minimized
	//gMinuit->SetPrintLevel(-1); /// set Minuit print level (-1: quiet (also suppresse all warnings); 0: normal; 1: verbose)

	double arglist[10];
	int ierflg = 0;

	arglist[0] = 1;
	gMinuit->mnexcm("SET ERR", arglist ,1,ierflg);
	
	
/// Set starting values and step sizes for parameters
	static double vstart[4] = {0.0, 0.0 , 0.0 , 0.0};
	static double step[4] = {0.1 , 0.1 , 0.1 , 0.01};	
	gMinuit->mnparm(0, "aP", vstart[0], step[0], 0,0,ierflg);
	gMinuit->mnparm(1, "arho", vstart[1], step[1], 0,0,ierflg);
	gMinuit->mnparm(2, "brho", vstart[2], step[2], 0,0,ierflg);
	gMinuit->mnparm(3, "Lambda", vstart[3], step[3], 0,0,ierflg);
	gMinuit->mnparm(4, "Cinf", 0.0,0.01, 0,0,ierflg);

	/*arglist[0] = 5;
	arglist[1] = 0.0;
	gMinuit->mnexcm("SET PARAM", arglist ,2,ierflg);
	arglist[0] = 5;
	gMinuit->mnexcm("FIX", arglist ,1,ierflg);
	
/// Now ready for minimization step
	arglist[0] = 500;
	arglist[1] = 1.;
	gMinuit->mnexcm("MIGRAD", arglist ,2,ierflg);
	
	arglist[0] = 5;
	gMinuit->mnexcm("RELEASE", arglist ,1,ierflg);
	/*arglist[0] = 5;
	gMinuit->mnexcm("FIX", arglist ,1,ierflg);*/
	
	arglist[0] = 4;
	arglist[1] = 0.0;
	gMinuit->mnexcm("SET PARAM", arglist ,2,ierflg);
	arglist[0] = 5;
	arglist[1] = 0.0;
	gMinuit->mnexcm("SET PARAM", arglist ,2,ierflg);
	arglist[0] = 4;
	arglist[1] = 5;
	gMinuit->mnexcm("FIX", arglist ,2,ierflg);
		
	/*arglist[0] = 4;
	arglist[1] = 0.5;
	gMinuit->mnexcm("SET PARAM", arglist ,2,ierflg);
	arglist[0] = 4;
	gMinuit->mnexcm("FIX", arglist ,1,ierflg);*/
	
	arglist[0] = 500;
	arglist[1] = 1.;
	gMinuit->mnexcm("MIGRAD", arglist ,2,ierflg);
		
	arglist[0] = 500;
	arglist[1] = 1.;
	gMinuit->mnexcm("HESSE", arglist ,2,ierflg);
	
/// Get parameter results
	double bnd1,bnd2,chi2,fval;
	int ivar;
	char* pname;
	TString parn(pname);
	gMinuit->mnpout(0, parn, fpars[0], ferrors[0], bnd1,bnd2,ivar);
	gMinuit->mnpout(1, parn, fpars[1], ferrors[1], bnd1,bnd2,ivar);
	gMinuit->mnpout(2, parn, fpars[2], ferrors[2], bnd1,bnd2,ivar);
	gMinuit->mnpout(3, parn, fpars[3], ferrors[3], bnd1,bnd2,ivar);
	gMinuit->mnpout(4, parn, fpars[4], ferrors[4], bnd1,bnd2,ivar);
}

TypeFitPars GetFitPars(){
	TypeFitPars fitPars;
	fcn2(fpars,&fitPars.chi2,&fitPars.ndof);	
	fitPars.redChi2 = fitPars.chi2/fitPars.ndof;
	double pf = kB*(kgamma-1.);
	fitPars.alphaP = fpars[0]/pf;
	fitPars.alphaP_err = ferrors[0]/pf;
	fitPars.alphaRho = fpars[1]/pf;
	fitPars.alphaRho_err = ferrors[1]/pf;
	fitPars.betaRho = fpars[2]/pf;
	fitPars.betaRho_err = ferrors[2]/pf;
	fitPars.lambda = fpars[3];
	fitPars.lambda_err = ferrors[3];
	fitPars.cinf = fpars[4];
	fitPars.cinf_err = ferrors[4];
	
	return fitPars;
}

void GetExpev(TypeBinData *fitData){
	double chi2;
	int dof;
	fcn2(fpars,&chi2,&dof,fitData);
}


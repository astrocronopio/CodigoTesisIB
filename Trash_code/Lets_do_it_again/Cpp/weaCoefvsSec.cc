/*
* Macro ROOT que toma archivo con los coeficientes de clima en bines de $sin^2(theta)$ (aPvssec,arhovssec,brhovssec) 
* y calcula el fit a un polinomio y luego grafica los resultados incluyendo los valores de los parámetros del fit.
*/
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <TStyle.h>
#include "TCanvas.h" 
#include "TGraph.h"
#include "TGraphErrors.h"
#include "TLatex.h"
#include "TAxis.h"
#include "TGaxis.h"
#include "TF1.h"
#include "TPaveStats.h"
#include "TPaveText.h"
#include "TROOT.h"
#include "TLegend.h"

using namespace std;

void plot2(const char* fileName,const char* ylabel,double* x1, double* y1, double* y1_err, TF1* fitfun1,double* x2,double* y2, double* y2_err, TF1* fitfun2)
{
    TCanvas *c = new TCanvas(Form("c_%s", fileName),Form("c_%s", fileName),700,500);	
	double x1_err[5] = {0.075,0.075,0.075,0.075,0.075};
	double x2_err[5] = {0.075,0.075,0.075,0.075,0.075};
    TGraphErrors *ge11 = new TGraphErrors(5, x1, y1, x1_err, y1_err);
    TGraphErrors *ge22 = new TGraphErrors(5, x2, y2, x2_err, y2_err);
    TGraphErrors *ge1 = new TGraphErrors(5, x1, y1, 0, y1_err);
    TGraphErrors *ge2 = new TGraphErrors(5, x2, y2, 0, y2_err);
    
    gPad->SetLeftMargin(0.15);
	//c->SetGrid();	
	//ge11->SetFillColor(2);
   	//ge11->SetFillStyle(3001);
   	ge22->SetTitle("");
	//ge22->GetXaxis()->SetTitle("Sec(#theta)");
	ge22->GetXaxis()->SetTitle("sin^2(#theta)");
	ge22->GetXaxis()->SetLimits(0.0,0.75);
	ge22->GetXaxis()->SetNdivisions(5,2,0);
	ge22->GetXaxis()->CenterTitle();
	ge22->GetXaxis()->SetLabelSize(0.04);
	ge22->GetXaxis()->SetTitleSize(0.04);
	ge22->GetYaxis()->SetTitle(ylabel);
	ge22->GetYaxis()->CenterTitle();
	ge22->GetYaxis()->SetTitleOffset(1.5);
	ge22->GetYaxis()->SetLabelSize(0.04);
	ge22->GetYaxis()->SetTitleSize(0.05);
	ge11->SetTitle("");
	ge22->GetXaxis()->SetTitle("sin^{2}(#theta)");
	ge11->GetXaxis()->SetLimits(0.0,0.75);
	ge11->GetXaxis()->SetNdivisions(5,2,0);
	ge11->GetXaxis()->CenterTitle();
	ge11->GetXaxis()->SetLabelSize(0.04);
	ge11->GetXaxis()->SetTitleSize(0.04);
	ge11->GetYaxis()->SetTitle(ylabel);
	ge11->GetYaxis()->CenterTitle();
	ge11->GetYaxis()->SetTitleOffset(1.5);
	ge11->GetYaxis()->SetLabelSize(0.04);
	ge11->GetYaxis()->SetTitleSize(0.05);
	
	ge22->SetLineColor(4);
	ge22->SetMarkerColor(4);
	ge11->SetLineColor(2);
	ge11->SetMarkerColor(2);
	ge11->SetFillColorAlpha(2,0.40);
	ge22->SetFillColorAlpha(4,0.40);
	ge1->SetMarkerColor(2);
	ge1->SetMarkerStyle(8);
	ge1->SetMarkerSize(0.5);
	ge2->SetMarkerColor(4);
	ge2->SetMarkerStyle(8);
	ge2->SetMarkerSize(0.5);
	
    
    ge1->Fit(fitfun1, "Q0", "", 0,0.75);
	ge2->Fit(fitfun2, "Q0", "", 0,0.75);
	fitfun1->SetLineColor(2);
	fitfun2->SetLineColor(4);
	gStyle->SetOptFit(0000);
	gPad->SetTicks();
			
	ge22->Draw("A2");
	if(fileName=='aP')ge22->GetYaxis()->SetRangeUser(-0.006,0.002); ///aP
	if(fileName=="arho")ge22->GetYaxis()->SetRangeUser(-2.8,0.0); ///arho
	if(fileName=="brho")ge22->GetYaxis()->SetRangeUser(-1.05,0.0); ///brho
	//ge22->Draw("SAME P");
	ge11->Draw("SAME 2");
	//ge11->Draw("SAME P");
	ge1->Draw("SAME PX");
	ge2->Draw("SAME PX");	
	fitfun1->Draw("SAME");
	fitfun2->Draw("SAME");
	
	TLegend*leg1 = new TLegend(0.7,0.72,0.85,0.9);
	leg1->AddEntry(ge11,"Herald","F");
	leg1->AddEntry(ge22,"Offline","F");
	leg1->Draw("SAME");
	
	c->SaveAs(Form("%svssin2a1_main_off.pdf", fileName));
///========== to include fit parameters in plot ====================================
	gStyle->SetOptFit();
	c->Update();
	TPaveStats *stats1 = (TPaveStats*)ge1->GetListOfFunctions()->FindObject("stats");
	stats1->SetTextColor(2);
	stats1->SetX1NDC(0.22); 
	stats1->SetX2NDC(0.50);
	TPaveStats *stats2 = (TPaveStats*)ge2->GetListOfFunctions()->FindObject("stats");
	stats2->SetTextColor(4);
	stats2->SetX1NDC(0.52); 
	stats2->SetX2NDC(0.80);
	//stats1->SetY1NDC(0.75);
	c->Modified();
    c->SaveAs(Form("%svssin2a1_main_off_wfitp.pdf", fileName));
}

void plot1(const char* fileName,const char* ylabel,double* x, double* y, double* y_err, TF1* fitfun)
{
    //TCanvas *c = new TCanvas(Form("c_%s", fileName),Form("c_%s", fileName),700,500);    
    TCanvas *c = new TCanvas(Form("c_%s", fileName),Form("c_%s", fileName),850,800);
	//double x_err[5] = {0.1,0.1,0.1,0.1,0.1};
	double x_err[5] = {0.075,0.075,0.075,0.075,0.075};
    TGraphErrors *ge = new TGraphErrors(5, x, y, x_err, y_err);
    TGraphErrors *ge1 = new TGraphErrors(5, x, y, x_err, 0);
    TGraphErrors *ge2 = new TGraphErrors(5, x, y, 0, y_err);
    //TLegend*leg=new TLegend(0.7,0.32,0.85,0.5);
    
	gPad->SetLeftMargin(0.24);
	gPad->SetRightMargin(0.03);
	gPad->SetBottomMargin(0.18);
	//c->SetGrid();
	ge->SetTitle("");	
	//ge->GetXaxis()->SetTitle("Sec(#theta)");
	//ge->GetXaxis()->SetLimits(1.0,2.0);
	ge->GetXaxis()->SetTitle("sin^{2}(#theta)");
	ge->GetXaxis()->SetLimits(0,0.75);
	ge->GetXaxis()->SetNdivisions(5,5,0);
	ge->GetXaxis()->CenterTitle();
	ge->GetXaxis()->SetTitleOffset(1);
	ge->GetXaxis()->SetLabelSize(0.05);
	ge->GetXaxis()->SetTitleSize(0.08);
	//ge->GetXaxis()->SetNoExponent(kTRUE);
	ge->GetYaxis()->SetTitle(ylabel);
	ge->GetYaxis()->CenterTitle();
	ge->GetYaxis()->SetTitleOffset(1.5);
	ge->GetYaxis()->SetLabelSize(0.05);//0.055
	ge->GetYaxis()->SetTitleSize(0.08);//0.07
	//TGaxis *myY = (TGaxis*)ge->GetYaxis();
	//myY->SetMaxDigits(4);
	//ge->SetFillColor(2);
   	//ge->SetFillStyle(3001);
   	//ge->SetFillColorAlpha(2,0.40);
	ge1->SetLineColor(2);
	ge1->SetLineWidth(1);
	ge2->SetLineColor(2);
	ge2->SetLineWidth(2.5);
	ge2->SetMarkerColor(2);
	ge2->SetMarkerStyle(8);
	ge2->SetMarkerSize(2);
    
	//ge2->Fit(fitfun, "Q", "", 1,2);
	ge2->Fit(fitfun, "Q0", "", 0,0.75);
	fitfun->SetLineColor(1);
	fitfun->SetLineWidth(0.3);
	gStyle->SetOptFit(0000);
	gPad->SetTicks();
	
	ge->Draw("APX");
	if(fileName=="aP")ge->GetYaxis()->SetRangeUser(-0.006,0.002); ///aP
	if(fileName=="arho")ge->GetYaxis()->SetRangeUser(-2.8,0.0); ///arho
	if(fileName=="brho")ge->GetYaxis()->SetRangeUser(-1.05,0.0); ///brho
	//ge1->Draw("SAME PZ");
	fitfun->Draw("SAME");
	ge2->Draw("SAME P");	
	c->SaveAs(Form("%svssin2a1_main4.eps", fileName));
	/*gStyle->SetOptFit();
	c->Update();	
	TPaveStats *stats1 = (TPaveStats*)ge2->GetListOfFunctions()->FindObject("stats");
	stats1->SetTextColor(1);
	stats1->SetX1NDC(0.32); 
	stats1->SetX2NDC(0.62); 
	//stats1->SetY1NDC(0.75);		
	c->Modified();
    c->SaveAs(Form("%svssin2a1_main_wfitp.pdf", fileName));*/
}

void plot2fit(const char* fileName,const char* ylabel,double* sec, double* coef, double* coef_err, TF1* fitfun1,TF1* fitfun2)
{
    TCanvas *c = new TCanvas(Form("c_%s", fileName),Form("c_%s", fileName),700,500);    
	double sec_err[5] = {0.1,0.1,0.1,0.1,0.1};
    TGraphErrors *ge = new TGraphErrors(5, sec, coef, sec_err, coef_err);
    TGraphErrors *ge2 = new TGraphErrors(5, sec, coef, 0, coef_err);
    TGraphErrors *ge3 = new TGraphErrors(5, sec, coef, 0, coef_err);
    TGraphErrors *ge4 = new TGraphErrors(5, sec, coef, sec_err, 0);
    
    
	gPad->SetLeftMargin(0.15);
	c->SetGrid();
	ge->SetTitle("");
	ge->SetLineColor(2);
	ge->SetMarkerColor(2);
	ge->SetFillColorAlpha(2,0.40);	
	ge->GetXaxis()->SetTitle("Sec(#theta)");
	ge->GetXaxis()->SetLimits(1.0,2.0);
	ge->GetXaxis()->SetNdivisions(5,0,0);
	ge->GetXaxis()->CenterTitle();
	ge->GetXaxis()->SetLabelSize(0.04);
	ge->GetXaxis()->SetTitleSize(0.04);
	ge->GetYaxis()->SetTitle(ylabel);
	ge->GetYaxis()->CenterTitle();
	ge->GetYaxis()->SetTitleOffset(1.5);
	ge->GetYaxis()->SetLabelSize(0.04);
	ge->GetYaxis()->SetTitleSize(0.05);
	
    ge4->SetLineColor(2);    
	ge2->Fit(fitfun1, "E", "", 1,2);
	ge3->Fit(fitfun2, "E", "", 1,2);
	fitfun1->SetLineColor(4);
	fitfun2->SetLineColor(1);
	gStyle->SetOptFit(0000);
	ge->Draw("A2");
	ge4->Draw("SAME PZ");
	ge2->Draw("SAME PX");
	ge3->Draw("SAME PX");
	fitfun1->Draw("SAME");
	fitfun2->Draw("SAME");
	
	TLegend*leg=new TLegend(0.6,0.32,0.9,0.5);
	leg->SetFillColor(0);
    leg->SetShadowColor(0);
    //leg->SetBorderSize(0);
    //leg->SetHeader("HeaderName");
    leg->AddEntry(fitfun1,"p0+p1(sec#theta-1)+p2(sec#theta-1)^{2}","l");
    leg->AddEntry(fitfun2,"p0+p1*exp#left(#minus p2*(sec#theta-1)#right)","l");
    leg->Draw();
    
	//c->SaveAs(Form("%svsseca1_main_gaus.pdf", fileName));
	gStyle->SetOptFit();
	c->Update();	
	TPaveStats *stats1 = (TPaveStats*)ge2->GetListOfFunctions()->FindObject("stats");
	stats1->SetTextColor(4);
	stats1->SetX1NDC(0.15); 
	stats1->SetX2NDC(0.40); 
	//stats1->SetY1NDC(0.75);
	TPaveStats *stats2 = (TPaveStats*)ge3->GetListOfFunctions()->FindObject("stats");
	stats2->SetTextColor(1);
	stats2->SetX1NDC(0.40); 
	stats2->SetX2NDC(0.65); 
	c->Modified();
    c->SaveAs(Form("%svsseca1_main_exp_wfitp.pdf", fileName));
}

void weaCoefvsSec()
{
	double sec[5],aP[5],aP_err[5],arho[5],arho_err[5],brho[5],brho_err[5];	
	string line;
	//ifstream coefs ("wcoefsvssin2a1.dat");
	ifstream coefs ("/home/ponci/Desktop/TesisLicenciaturaBalseiro/Taborda_Original/wcoefsvssin2a1.dat");
	if(coefs.is_open())
	{    
		int i = 0;
		while (!coefs.eof() ){			
			getline(coefs,line);
			stringstream liness(line);
			liness >> sec[i] >> aP[i] >> aP_err[i] >> arho[i] >> arho_err[i] >> brho[i] >> brho_err[i];
			i++;
		}
	}
	else cout << "Unable to open file";
	
	//TF1 *fFit = new TF1("fFit","[0]+[1]*(x-1)+[2]*(x-1)*(x-1)",1,2); ///fit function	
	TF1 *fFit = new TF1("fFit","[0]+[1]*x+[2]*x*x",0,0.75); ///fit function
	//TF1 *fFit = new TF1("fFit","[0]+[1]*exp(-[2]*(x-1))",1,2); ///fit function	
	//TF1 *fFit2 = new TF1("fFit2","[0]+[1]*x+[2]*x*x",0,0.75);
	/*fFit->SetParameter(0,-0.002);
	fFit->SetParameter(1,0);
	fFit->SetParameter(2,0);
	fFit2->SetParameter(0,-0.002);
	fFit2->SetParameter(1,0);
	fFit2->SetParameter(2,0);*/
	plot1("aP","#font[12]{a}_{P} [hPa^{-1}]",sec,aP,aP_err,fFit);
	plot1("arho","#font[12]{a}_{#rho} [kg^{-1}m^{3}]",sec,arho,arho_err,fFit);
	plot1("brho","#font[12]{b}_{#rho} [kg^{-1}m^{3}]",sec,brho,brho_err,fFit);
	
	/*double sec2[5],aP2[5],aP_err2[5],arho2[5],arho_err2[5],brho2[5],brho_err2[5];
	//TF1 *fFit2 = new TF1("fFit2","[0]+[1]*(x-1)+[2]*(x-1)*(x-1)",1,2);
	ifstream coefs2 ("wcoefsvssin2a1_offline.dat");
	if(coefs2.is_open())
	{    
		int i = 0;
		while (!coefs2.eof() ){			
			getline(coefs2,line);
			stringstream liness(line);
			liness >> sec2[i] >> aP2[i] >> aP_err2[i] >> arho2[i] >> arho_err2[i] >> brho2[i] >> brho_err2[i];
			i++;
		}
	}
	else cout << "Unable to open file";*/
	
	//plot2("aP","#font[12]{a}_{P} [hPa^{-1}]",sec,aP,aP_err,fFit,sec2,aP2,aP_err2,fFit2);
	//plot2("arho","#font[12]{a}_{#rho} [kg^{-1}m^{3}]",sec,arho,arho_err,fFit,sec2,arho2,arho_err2,fFit2);
	//plot2("brho","#font[12]{b}_{#rho} [kg^{-1}m^{3}]",sec,brho,brho_err,fFit,sec2,brho2,brho_err2,fFit2);
	
	//plot2fit("aP","#alpha_{P} [hPa^{-1}]",sec,aP,aP_err,fFit,fFit2);
	//plot2fit("arho","#alpha_{#rho} [kg^{-1}m^{3}]",sec,arho,arho_err,fFit,fFit2);
	//plot2fit("brho","#beta_{#rho} [kg^{-1}m^{3}]",sec,brho,brho_err,fFit,fFit2);
	
}


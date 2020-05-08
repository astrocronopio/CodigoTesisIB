#include "exposure.h"

int main(int argc, char const *argv[])
{
	unsigned long rango2004=1072915200;
	unsigned long rango2005=1104537600;
	unsigned long rango2013=1388628499; 
	unsigned long rango2017=1472688000;
	unsigned long rango2019=1546387228;
	
	unsigned long utci =  rango2013; //2005
	unsigned long utcf =  rango2019;//1577825634; //2016
/*	
	int interval = 24;
	const char* out_file_S 	= "./sideral_24.txt";
	const char* out_file 	= 	"./solar_24.txt";
	const char* out_file_a 	= 	 "./anti_24.txt";

	//exposure_sideral( out_file_S, utci, utcf, interval);
	//exposure_given_period(T_D, out_file, utci, utcf, interval);
	//exposure_given_period(T_A, out_file_a, utci, utcf, interval);
	


	interval = 360;
	const char* out_file_S_1 	= "./sideral_360.txt";
	const char* out_file_1 		= 	"./solar_360.txt";
	const char* out_file_a_1 	= 	 "./anti_360.txt";
	exposure_given_period(T_S, out_file_S_1, utci, utcf, interval);
	exposure_given_period(T_D, out_file_1, utci, utcf, interval);
	exposure_given_period(T_A, out_file_a_1, utci, utcf, interval);
	
*/


	int interval = 288;
	const char* out_file_sidereal	= "./sideral_2019_report_on_anisotropy_288_2013_2019.txt";

	const char* out_file_2 		= 	"./solar_2019_report_on_anisotropy_288_2013_2019.txt";
	const char* out_file_a_2 	= 	 "./anti_2019_report_on_anisotropy_288_2013_2019.txt";

	std::cout << "Sidereal "<< std::endl;
	exposure_given_period(T_S, "./sideral_2019_report_on_anisotropy_288_2013_2019_1.txt", utci, utcf, interval);
	exposure_sideral		 ( "./sideral_2019_report_on_anisotropy_288_2013_2019_2.txt", utci, utcf, interval);
	
	 
	std::cout << "Solar "<< std::endl;

	exposure_given_period(T_D, out_file_2, utci, utcf, interval);
	std::cout << "Anti-sidereal "<< std::endl;
	
	exposure_given_period(T_A, out_file_a_2, utci, utcf, interval);

	return 0;
}
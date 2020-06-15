#include "exposure_v4.h"

unsigned long rango2004=1072915200;
unsigned long rango2005=1104537600;
unsigned long rango2013=1388577600; 
unsigned long rango2017=1472688000;
unsigned long rango2019=1546344000;
unsigned long rango2020=1577880000;

//Frequency in SIDEREAL DAYS
long double T_S	= 366.25,  T_D = 365.25,  T_A=364.25 ;


int interval = 288;

/*int version_v1()
{
	
	unsigned long utci =  rango2013; //2005
	unsigned long utcf =  rango2020;//1577825634; //2016
	const char* out_file_sidereal	= "./sideral_2019_report_288_2014_2020.txt";
	const char* out_file_2 			= 	"./solar_2019_report_288_2014_2020.txt";
	const char* out_file_a_2 		= 	 "./anti_2019_report_288_2014_2020.txt";

	std::cout << "Sidereal "<< std::endl;
	exposure_given_period(T_S, "./sideral_2019_report_288_2014_2020_1.txt", utci, utcf, interval);
 
	std::cout << "Solar "<< std::endl;

	exposure_given_period(T_D, out_file_2, utci, utcf, interval);
	std::cout << "Anti-sidereal "<< std::endl;
	
	exposure_given_period(T_A, out_file_a_2, utci, utcf, interval);

	return 0;
}
*/
/*int version_V2()
{
	unsigned long utci =  rango2004;
	unsigned long utcf =  rango2017;

	int interval = 288;

	std::cout << "Sidereal 2019:"<< std::endl;
	exposure_given_period(T_S, "solar_2019.txt", utci, utcf, interval);

	std::cout << "Sidereal 2020:"<< std::endl;
	utcf =  rango2020;
	exposure_given_period(T_S, "solar_2020.txt", utci, utcf, interval);

	return 0;

}*/



int version_v3()
{
	//exposure_given_period(T_S, "sidereal_2020_sol_sin_2.txt", rango2013, rango2020, interval,							method_weight_solar);
	//exposure_given_period(T_S, "sidereal_2020_sid.txt", rango2013, rango2020, interval,	method_weight_sidereal);
	
	exposure_given_period(T_D, "solar_2020_sol.txt", rango2013, rango2020,  interval, method_weight_solar);
	//exposure_given_period(T_D, "solar_2020_sid.txt", rango2013, rango2020, 	interval, method_weight_sidereal);

//	exposure_given_period(T_A, "antisiderea_2020_sol.txt", rango2013, rango2020, interval, method_weight_solar);
//	exposure_given_period(T_A, "antisiderea_2020_sid.txt", rango2013, rango2020, interval, method_weight_sidereal);

	return 0;
}

int main(int argc, char const *argv[])
{
	//version_v1();
	//version_V2();
	
	version_v3();

	return 0;
}
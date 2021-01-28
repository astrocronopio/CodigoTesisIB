#include "exposure_v5.h"

unsigned long rango2004=1072915200;
unsigned long rango2005=1104537600;
unsigned long rango2013=1388577600; 
unsigned long rango2017=1472688000;
unsigned long rango2019=1546344000;
unsigned long rango2020=1577880000;

//Frequency in SIDEREAL DAYS
long double T_S	= 366.25,  T_D = 365.25,  T_A=364.25 ;


int interval = 288;

int version_v3()
{
	// exposure_given_period(T_S, "sidereal_2004-2017_sol.txt"		, rango2004, rango2017, interval, method_weight_solar);
	// exposure_given_period(T_D, "solar_2004-2017_sol.txt"		, rango2004, rango2017,  interval, method_weight_solar);
	// exposure_given_period(T_A, "antisiderea_2004-2017_sol.txt"	, rango2004, rango2017, interval, method_weight_solar);

	exposure_given_period(T_S, "sidereal_2013-2020_sol.txt", rango2013, rango2020, interval, method_weight_solar);
	// exposure_given_period(T_D, "solar_2013-2020_sol.txt", rango2013, rango2020,  interval, method_weight_solar);
	// exposure_given_period(T_A, "antisiderea_2013-2020_sol.txt", rango2013, rango2020, interval, method_weight_solar);

	return 0;
}

int main(int argc, char const *argv[])
{
	
	version_v3();

	return 0;
}
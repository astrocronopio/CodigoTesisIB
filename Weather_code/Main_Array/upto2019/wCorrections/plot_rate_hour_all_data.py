import numpy as np


def bin_mean(infile, outfile):
	h6hr= np.zeros(24) 
	counter= np.zeros(24)
	event=np.zeros(24)
	h6= np.zeros(24)

	with open(infile) as f:
		for line in f:
			utc, events, x, y, t, h6, rate = line.split()
	
			hr = int(int(utc)/3600)%24
			h6hr[hr] += float(h6)
			event[hr]+= float(events)
			counter[hr]+= 1

		out=open(outfile, "w")
		for x in xrange(0,24):
			out.write("{0}\t{1} \t {2}\n".format(x, event[x] ,h6hr[x]))
			pass
		out.close()

def bin_mean_rate(infile, outfile):
	h6hr= np.zeros(24) 
	counter= np.zeros(24)

	with open(infile) as f:
		for line in f:
			utc, rate = line.split()
	
			hr = int(int(utc)/3600)%24
			h6hr[hr] += float(rate)

			counter[hr]+= 1

		out=open(outfile, "w")
		for x in xrange(0,24):
			out.write("{0}\t{1}\n".format(x, h6hr[x]/counter[x]))
			pass
		out.close()


def main():
	file_herald 			= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_hour.dat"#sys.argv[1]
	out_file_herald 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_hour_all_data.dat"#sys.argv[1]

	bin_mean(file_herald, out_file_herald)

	file_herald_rate 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_rate_hour.dat"#sys.argv[2]
	out_file_herald_rate 	= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_rate_hour_all_data.dat"#sys.argv[2]

	bin_mean_rate(file_herald_rate, out_file_herald_rate)

  
if __name__== "__main__":
	main()

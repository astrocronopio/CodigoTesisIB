import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [12, 8],  'figure.autolayout': True})


counter=0

def over3(array):
	counter=0
	for x in array:
		if x>(np.log10(3)+18):
			counter+=1
			pass
	return counter
	pass

# 
#values = np.loadtxt("./energia_2015.dat")
hist2009=np.log10(np.loadtxt("./energia_2005_2009.dat"))+18.0
hist2012=np.log10(np.loadtxt("./energia_2009_2012.dat"))+18.0
hist2015=np.log10(np.loadtxt("./energia_2012_2015.dat"))+18.0
hist2018=np.log10(np.loadtxt("./energia_2015_2018.dat"))+18.0


norm_hist2009=over3(hist2009)
print(norm_hist2009)
norm_hist2012=over3(hist2012)
print(norm_hist2012)
norm_hist2015=over3(hist2015)
print(norm_hist2015)
norm_hist2018=over3(hist2018)
print(norm_hist2018)

"""

for x in d1:
	if x<5:
		d.append(x)
		pass
	pass


for x in p1:
	if x<5:
		p.append(x)
		pass
	pass
"""

#plt.hist(values,5, histtype='step', align='mid', color='g', label='Test Score Data')
#plt.legend(loc=2)
#plt.title('Histogram of score')
#plt.show()
#
#

#import seaborn as sns

w_hist2009=np.ones_like(hist2009)/float((norm_hist2009))
w_hist2012=np.ones_like(hist2012)/float((norm_hist2012))
w_hist2015=np.ones_like(hist2015)/float((norm_hist2015))
w_hist2018=np.ones_like(hist2018)/float((norm_hist2018))


fig, ax1 = plt.subplots()

# These are in unitless percentages of the figure size. (0,0 is bottom left)
left, bottom, width, height = [0.4, 0.2, 0.4, 0.3]
ax2 = fig.add_axes([left, bottom, width, height])

#ax1.plot(range(10), color='red')
#ax2.plot(range(6)[::-1], color='green')




ax1.hist(hist2009, histtype='step', bins=70, weights=w_hist2009, label=u'2005-2009, $\~E=1.000\,$EeV')
ax2.hist(hist2009, histtype='step', bins=70, weights=w_hist2009, label='2005-2009')

ax1.hist(hist2012, histtype='step', bins=70, weights=w_hist2012, label=u'2009-2012, $\~E=1.066\,$EeV')
ax2.hist(hist2012, histtype='step', bins=70, weights=w_hist2012, label='2009-2012')

ax1.hist(hist2015, histtype='step', bins=70, weights=w_hist2015, label=u'2012-2015, $\~E=1.105\,$EeV')
ax2.hist(hist2015, histtype='step', bins=70, weights=w_hist2015, label='2012-2015')

ax1.hist(hist2018, histtype='step', bins=70, weights=w_hist2018, label=u'2015-2018, $\~E=1.137\,$EeV')
ax2.hist(hist2018, histtype='step', bins=70, weights=w_hist2018, label='2015-2018')

ax1.set_xlim(17,19.5)
ax2.set_xlim(17.5,18.3)
ax1.set_ylim(0.0001, 5)
ax1.legend(loc=1)
ax1.set_ylabel(u'$N_{eventos}$/$N_{eventos >3EeV}$')
ax1.set_xlabel("log(E)")

#import statistics

#print(statistics.median(myarray))
#print(statistics.median(myarray1))
#
#print(statistics.mean(myarray))
#print(statistics.mean(myarray1))

#sns.set_style('darkgrid')
#sns.distplot(d1,norm_hist=False)
#sns.distplot(p1,norm_hist=False)
plt.show()
import matplotlib.pyplot as plt
import numpy as np
# 
#values = np.loadtxt("./energia_2015.dat")
myarray=np.log(np.loadtxt("./energia_2015.dat"))
d=[]
myarray1=np.log(np.loadtxt("./energia_2018.dat"))
p=[]

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

import seaborn as sns

weights = np.ones_like(myarray)/float(len(myarray))
weights1 = np.ones_like(myarray1)/float(len(myarray1))

plt.hist(myarray, weights=weights, bins=1000)
plt.hist(myarray1, weights=weights1, bins=1000)


#sns.set_style('darkgrid')
#sns.distplot(d1,norm_hist=False)
#sns.distplot(p1,norm_hist=False)
plt.show()
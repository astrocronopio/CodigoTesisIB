import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np

filebesell="./barrido_pdf.txt"

i, r, pdf, prob = np.loadtxt(filebesell, unpack=True)
#################################################################

# fig,ax = plt.subplots()
# ax.set_ylabel("Densidad de probabilidad p($d_{\perp}$)")
# ax.set_xlabel("Amplitud $d_{\perp}$")
# ax.plot(r, pdf, label="PDF", color='red', alpha=1)
# ax.legend(loc=(0.5,0.6))

# ax2=ax.twinx()
# ax2.plot(r, prob, ls='--', label="Integral",color='blue', alpha=0.7)
# ax2.set_ylabel("Probabilidad")
# ax2.legend(loc=(0.5,0.7))
    
# # plt.legend()
# plt.show()
# exit()
#####################################################################    

# plt.figure(2)

# plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
# plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

# #Dperp value#
# plt.xlabel("Amplitud $d_{\perp}$")
# plt.ylabel("Densidad de probabilidad p($d_{\perp}$)")
# plt.scatter([r_s],[93.3451], color='black',marker='x', s=350, lw=3, label="Valor $s$")

# plt.legend()
# plt.show()
# exit()
#######################################    
#####################################################################    

plt.figure(4)

r_s = 0.006
pdf_s=93.3451
plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

#Dperp value#
plt.xlabel("Amplitud $d_{\perp}$")
plt.ylabel("Densidad de probabilidad p($d_{\perp}$)")
plt.scatter([r_s],[93.3451], color='black',marker='x', s=350, lw=3, label="Valor $s$")

#Dperp lower limit#
r_min=0.00342	
pdf_min=63.7102
pos_min=56

plt.scatter([r_min],[pdf_min], color='red', s=20)
plt.plot([r_min,r_min],[0,pdf_min], color='red', ls=':')
# plt.text(0.9*r_min,pdf_min, "$s-\sigma^-$", ha='right')

#Dperp upper limit#
r_max=0.01146
pdf_max=63.4796
pos_max=190

plt.scatter([r_max],[pdf_max], color='red', s=20, label="Límites")
plt.plot([r_max,r_max],[0,pdf_max], color='red', ls=':')
plt.text(1.1*r_max, 1.01*pdf_max, "N iteración", ha='left')
plt.axhline(pdf_max ,  color='black', lw=1.5, alpha=0.8)
plt.fill_between(r[pos_min:pos_max],pdf[pos_min:pos_max], color='red', alpha=0.1)

plt.text(1.3*r_s, .999*pdf_s, "1 iteración", ha='left')
plt.axhline(.99*pdf_s ,  color='black', lw=1.5, alpha=0.8)


plt.legend()
plt.show()
exit()

#######################################
#######################################    
#####################################################################    

plt.figure(4)

plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

#Dperp value#
plt.xlabel("Amplitud $d_{\perp}$")
plt.ylabel("Densidad de probabilidad p($d_{\perp}$)")
plt.scatter([r_s],[93.3451], color='black',marker='x', s=350, lw=3, label="Valor $s$")

#Dperp lower limit#
r_min=0.00342	
pdf_min=63.7102
pos_min=56

plt.scatter([r_min],[pdf_min], color='red', s=20)
plt.plot([r_min,r_min],[0,pdf_min], color='red', ls=':')
plt.text(0.9*r_min,pdf_min, "$s-\sigma^-$", ha='right')

#Dperp upper limit#
r_max=0.01146
pdf_max=63.4796
pos_max=190

plt.scatter([r_max],[pdf_max], color='red', s=20, label="Límites")
plt.plot([r_max,r_max],[0,pdf_max], color='red', ls=':')
plt.text(1.1*r_max,pdf_max, "$s+\sigma^+$", ha='left')

plt.fill_between(r[pos_min:pos_max],pdf[pos_min:pos_max], color='red', alpha=0.1)


#Reported upper and lower limits#
r_max=0.01098
pdf_max=69.4899
plt.scatter([r_max],[pdf_max], color='black', s=100, marker="s", label="$s+\sigma^+$ reportado")
plt.plot([r_max,r_max],[0,pdf_max], color='black', ls='-.', alpha=0.5)

r_max=0.003
pdf_max=56.8097
plt.scatter([r_max],[pdf_max], color='black', s=100, marker="o", label="$s-\sigma^-$ reportado")
plt.plot([r_max,r_max],[0,pdf_max], color='black', ls='-.', alpha=0.5)


plt.legend()
plt.show()


#######################################
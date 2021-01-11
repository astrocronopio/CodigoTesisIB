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

filebesell="./barrido_pdf+r.txt"

i, r, pdf, prob = np.loadtxt(filebesell, unpack=True)
#################################################################

def plot_pdf_prob():
    fig,ax = plt.subplots()
    ax.set_ylabel("Densidad de probabilidad p($r$)")
    ax.set_xlabel("Amplitud $r$")
    ax.plot(r, pdf, label="PDF", color='red', alpha=1)
    ax.legend(loc=(0.5,0.6))

    # ax2=ax.twinx()
    # ax2.plot(r, prob, ls='--', label="Integral",color='blue', alpha=0.7)
    # ax2.set_ylabel("Probabilidad")
    # ax2.legend(loc=(0.5,0.7))
        
    # plt.legend()
    plt.show()
    exit()
#####################################################################    

def plot_pdf_s():
    plt.figure(2)
    r_s = 0.00477
    pdf_s=93.3451
    
    plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
    plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

    #Dperp value#
    plt.xlabel("Amplitud ${r}$")
    plt.ylabel("Densidad de probabilidad p(${r}$)")
    plt.scatter([r_s],[93.3451], color='black',marker='x', s=350, lw=3, label="Valor $s$")

    plt.legend()
    plt.show()
    exit()
#######################################    
#####################################################################    

def plot_iterations():
    plt.figure(4)

    r_s = 0.006
    pdf_s=93.3451
    plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
    # plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

    #Dperp value#
    plt.xlabel("Amplitud ${r}$")
    plt.ylabel("Densidad de probabilidad p(${r}$)")
    plt.scatter([r_s],[pdf_s], color='black',marker='o', s=35, lw=3, label="Valor $s$")

    #Dperp lower limit#
    r_min=0.00342	
    pdf_min=63.7102
    pos_min=56

    # plt.scatter([r_min],[pdf_min], color='red', s=20)
    plt.plot([r_min,r_min],[0,pdf_min], color='red', ls=':')
    # plt.text(0.9*r_min,pdf_min, "$s-\sigma^-$", ha='right')

    #Dperp upper limit#
    r_max=0.01146
    pdf_max=63.4796
    pos_max=190
    
    mid_1=71	
    mid_1_x=0.00426	
    mid_1_y=76.0601
    
    
    mid_2=174	
    mid_2_x=0.01044
    mid_2_y=75.9629

    # plt.scatter([r_max],[pdf_max], color='red', s=20, label="Límites")
    plt.plot([r_max,r_max],[0,pdf_max], color='red', ls=':')
    plt.text(2.*r_s, 1.01*pdf_max, "N iteración", ha='left')
    plt.text(0.15*r_s, 1.012*pdf_max, "$p(r)_N$", ha='left')
    plt.axhline(pdf_max , xmin=0.05, xmax=0.7, color='black', lw=1.5, alpha=0.6)
    plt.fill_between(r[pos_min:mid_1],pdf[pos_min:mid_1], color='red', alpha=0.2)
    plt.fill_between(r[mid_2:pos_max],pdf[mid_2:pos_max], color='red', alpha=0.2)
    
    plt.text(2.*r_s, .989*pdf_s, "1 iteración", ha='left')
    plt.text(0.15*r_s, .99*pdf_s, "$p(r)_1$", ha='left')
    plt.axhline(.98*pdf_s , xmin=0.05, xmax=0.7, color='green', lw=1.5, alpha=0.6)
    plt.fill_between(r[96:145], pdf[96:145], color='green', alpha=0.3, hatch="X")

    plt.text(2.*r_s, .825*pdf_s, "Iteración intermedia", ha='left')
    plt.text(0.15*r_s, .826*pdf_s, "$p(r)_{k}$", ha='left')
    plt.axhline(.82*pdf_s, xmin=0.05, xmax=0.7, color='blue', lw=1.5, alpha=0.6)
    plt.fill_between(r[mid_1:96], pdf[mid_1:96], color='blue', alpha=0.3, hatch="+")
    plt.fill_between(r[145:mid_2], pdf[145:mid_2], color='blue', alpha=0.3, hatch="+")

    plt.legend()
    plt.show()
    exit()

#######################################
#######################################    
#####################################################################    

def plot_all_points():
    plt.figure(4)

    plt.plot(r,pdf, color='red', alpha=0.7, label="PDF")
    plt.plot([r_s,r_s],[0,93.3451], color='red', ls='-.')

    #Dperp value#
    plt.xlabel("Amplitud ${r}$")
    plt.ylabel("Densidad de probabilidad p(${r}$)")
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

if __name__ == "__main__":
    plot_pdf_prob()
    # plot_all_points()
    # plot_iterations()
    pass
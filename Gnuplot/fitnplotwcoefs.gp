## Realiza fit y gráfico de los coeficientes de clima en bines de $\sec\theta$
##
set style fill solid 0.5
set grid
set xlabel 'sec({/Symbol q})'
f(x) = A+B*(x-1)+C*(x-1)**2
A=1;B=1;C=1
set title ''
set size 0.6,0.6
# set to enhanced eps terminal that allows greek letters
set terminal postscript eps enhanced color
set key top left
# Output file
set output "aPvssec.eps"
set ylabel '{/Symbol a}_P(hPa^{-1})'
fit f(x) 'aPvssec' u 1:2:3 via A,B,C
plot [1:2] 'aPvssec2' u 1:($2+$3):($2-$3) w filledcu title '', f(x) title 'f(x) = c_0+c_1x+c_2x^2' ls 1 lc 3 lw 1.5

set output "arhovssec.eps"
set ylabel '{/Symbol a}_{/Symbol r}(kg^{-1}m^3)'
fit f(x) 'arhovssec' u 1:2:3 via A,B,C
plot [1:2] 'arhovssec2' u 1:($2+$3):($2-$3) w filledcu title '', f(x) title 'f(x) = c_0+c_1x+c_2x^2' ls 1 lc 3 lw 1.5

set output "brhovssec.eps"
set ylabel '{/Symbol b}_{/Symbol r}(kg^{-1}m^3)'
fit f(x) 'brhovssec' u 1:2:3 via A,B,C
plot [1:2] 'brhovssec2' u 1:($2+$3):($2-$3) w filledcu title '', f(x) title 'f(x) = c_0+c_1x+c_2x^2' ls 1 lc 3 lw 1.5

set term wxt 0

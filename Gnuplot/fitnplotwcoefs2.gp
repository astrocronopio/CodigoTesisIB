set style fill solid 0.5
set grid
set xlabel 'sec({/Symbol q})'
f(x) = A+B*(x-1)+C*(x-1)**2
g(x) = A1+B1*(x-1)+C1*(x-1)**2
h(x) = B2*(x-2)+C2*(x-2)**2
A=1;B=1;C=1
A1=1;B1=1;C1=1
B2=1;C2=1
set title ''
set size 0.6,0.6
# set to enhanced eps terminal that allows greek letters
set terminal postscript eps enhanced color solid
set key top left
# Output file
set output "aPvsseca1.eps"
set ylabel '{/Symbol a}_P(hPa^{-1})'
fit f(x) 'aPvssec' u 1:2:3 via A,B,C
fit g(x) 'aPvsseca1.dat' u 1:2:3 via A1,B1,C1
plot [1:2] 'aPvssec' u 1:2:3 w e pt 7 lc 0 title 'All E', f(x) title '' ls 1 lc 0 lw 1.5, 'aPvsseca1.dat' u 1:2:3 w e pt 7 lc 3 title 'E > 1 EeV', g(x) title '' ls 1 lc 3 lw 1.5

set output "arhovsseca1.eps"
set ylabel '{/Symbol a}_{/Symbol r}(kg^{-1}m^3)'
fit f(x) 'arhovssec' u 1:2:3 via A,B,C
fit g(x) 'arhovsseca1.dat' u 1:2:3 via A1,B1,C1
plot [1:2] 'arhovssec' u 1:2:3 w e pt 7 lc 0 title 'All E', f(x) title '' ls 1 lc 0 lw 1.5,'arhovsseca1.dat' u 1:2:3 w e pt 7 lc 3 title 'E > 1 EeV', g(x) title '' ls 1 lc 3 lw 1.5

set output "brhovsseca1.eps"
set ylabel '{/Symbol b}_{/Symbol r}(kg^{-1}m^3)'
fit f(x) 'brhovssec' u 1:2:3 via A,B,C
fit g(x) 'brhovsseca1.dat' u 1:2:3 via A1,B1,C1
plot [1:2] 'brhovssec' u 1:2:3 w e pt 7 lc 0 title 'All E', f(x) title '' ls 1 lc 0 lw 1.5,'brhovsseca1.dat' u 1:2:3 w e pt 7 lc 3 title 'E > 1 EeV', g(x) title '' ls 1 lc 3 lw 1.5

set term wxt 0

gauss(x)=1/(sigma*sqrt(2.*pi))*exp(-(x)**2./(2.*sigma**2))
gauss2(x)=1/(sigma2*sqrt(2.*pi))*exp(-(x)**2./(2.*sigma2**2))
gauss3(x)=1/(sigma3*sqrt(2.*pi))*exp(-(x)**2./(2.*sigma3**2))

set terminal qt 0 enhanced font 'times,26' size 1200,800 
set key left


sigma=0.5
sigma2=1.117010721/2
sigma3=0.785398163*sqrt(2)/2
plot gauss(x) lw 2  dt 2 tit "Ajuste Gauss"
fit gauss(x) "barrido_pdf+phase.txt" u 2:3 via sigma

replot "barrido_pdf+phase.txt" u 2:3 w l lw 3 lc rgb 'red'  tit "Función Exacta"
replot gauss2(x) lw 2 dt 4 tit "Gauss (sigma reportado)" 
replot gauss3(x) lw 2 dt 5 tit "Gauss sigma*sqrt(2)"
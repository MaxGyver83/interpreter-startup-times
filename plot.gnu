load 'turbo.pal'
set cbrange [0:100]
if (!exists("outfile")) outfile='graph.png'
if (exists("log")) set logscale y 10; set logscale cb; set cbrange [0:1000]; unset colorbox
set term png size 1080,600
set output outfile
set title font "Monospaced,14" 'Startup times'
set ylabel "Milliseconds"
set grid
set boxwidth 0.5
set style fill solid
plot '< cat - | nl' using 1:3:3:xtic(2) notitle with boxes fillstyle solid lc palette z lw 3

# Interpreter startup times benchmark

This repository contains a (bash) [script](./measure-startup-times) to measure
the startup times of various scripting language intepreters and a (POSIX shell)
[script](./create-plot) to plot the results with gnuplot.

Startup times are determined by starting every interpreter with an empty
expression 30 times and then calculating the average.

[results.txt](./results.txt) contains the results for selected scripting
languages as measured on my laptop (ASUS B9440UA, from 2017) with Arch Linux
installed.

## Startup times for all interpreters faster than 100 ms

![below 100ms](https://maximilian-schillinger.de/img/below_100ms.png)

## Startup times for all interpreters faster than 10 ms

![fastest interpreters](https://maximilian-schillinger.de/img/fast.png)

## Startup times for all interpreters slower than 10 ms

![slowest interpreters](https://maximilian-schillinger.de/img/slow.png)

## Versions

```
 groovy: Groovy Version: 4.0.12 JVM: 1.8.0_372 Vendor: Oracle Corporation OS: Linux
  xonsh: xonsh/0.14.0
   node: v20.2.0
   ruby: ruby 3.0.5p211 (2022-11-24 revision ba5cf0f7c5) [x86_64-linux]
     nu: 0.81.0
 python: Python 3.11.3
    php: PHP 8.2.7 (cli) (built: Jun 10 2023 08:47:39) (NTS)
     rc: 2023-04-19
   fish: fish, version 3.6.1
  clisp: GNU CLISP 2.49.93+ (2018-02-18) (built on root2 [65.108.105.205])
    zsh: zsh 5.9 (x86_64-pc-linux-gnu)
   bash: GNU bash, Version 5.1.16(1)-release (x86_64-pc-linux-gnu)
   yash: Yet another shell, version 2.52
   perl: This is perl 5, version 36, subversion 1 (v5.36.1) built for x86_64-linux-thread-multi
    lua: Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio
   mrsh: 2022-09-14
   oksh: oksh 7.2-1
 luajit: LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2022 Mike Pall. https://luajit.org/
   dash: dash 0.5.12-1
   mksh: @(#)MIRBSD KSH R59 2023/06/03
    ash: BusyBox v1.34.1 () multi-call binary.
```

## Remarks

- How fast an interpreter starts is only one of multiple factors if you want to
  compare the "speed" of scripting languages.
- This comparison is only about script execution, not about interactive mode.
- The loop (of 30 iterations) itself is contained in the average startup times.
  That's why I have added a "no-operations" (`noop`) entry which does 30 times
  nothing. This takes on average 0.03 ms per iteration. Subtract this from all
  results for correct numbers.
- `ash` is actually `busybox ash`.
- [rc](https://git.sr.ht/~sircmpwn/rc) and
  [mrsh](https://git.sr.ht/~emersion/mrsh) are not yet finished/released. I have
  added them anyway.
- I don't use all of these languages. If any result is unexpected (maybe
  because of a bad configuration on my laptop), just send me an e-mail or create
  an issue.
- My locale is `de_DE.UTF-8`. When I set `LC_ALL` to `C` and run
  `./measure-startup-times` again, `zsh`, `bash` and `yash` run much faster.
  `oksh` runs much slower. For all others I get similar results as before.
- The included [gnuplot script](./plot.gnu) uses the [Turbo
  colormap](https://ai.googleblog.com/2019/08/turbo-improved-rainbow-colormap-for.html)
  from the
  [Gnuplotting/gnuplot-palettes](https://github.com/Gnuplotting/gnuplot-palettes)
  repo.
  [turbo.pal](https://github.com/Gnuplotting/gnuplot-palettes/blob/master/turbo.pal)
  is not included in this repo because I'm not a license expert. Just
  clone/download it yourself.

## Usage

If you want to reproduce these results, you should have all interpreters listed
above plus `gnuplot` installed (and `wget` or a browser for downloading
`turbo.pal`).

```sh
./measure-startup-times all | tee results.txt
wget https://raw.githubusercontent.com/Gnuplotting/gnuplot-palettes/master/turbo.pal
./create-plot all-plots
```

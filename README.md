# WindStat
WindStat prepares histogram of the input time-series of winds, perform long term wind statistics and extreme wind statistics including peak over threshold sampling and storm averaging. It calculates wind statistics and writes its outputs. 
- Inputs should be placed in inputs directory (input.mat is example)
- wind_stat.m should be executed in order to use WindStat tool.
- Necessary changes and selections can be done from wind_stat.m script.
- When all options are enabled, it will draw a wind histogram, wind long term wind statistics curves and results and wind extreme statistics will be plotted.
- All results will be placed in outputs folder.
- If POT is enabled, it might go into an infinite loop, if so change upper and lower pot limit values in the extreme wind statistics option.
- It might give warning for imaginary numbers, it is not important.
- Some features in extreme wind statistics are adapted from H. G. Güler (2017).

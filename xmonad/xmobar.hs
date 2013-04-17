-- xmobar config used by Vic Fryzel
-- Author: Vic Fryzel
-- http://github.com/vicfryzel/xmonad-config

Config {
    font = "xft:Fixed-8",
    bgColor = "#002b36",
    fgColor = "#657b83",
    position = Top,
    lowerOnStart = True,
    commands = [
        Run Weather "KPHX" ["-t","<tempF> <skyCondition>","-L","64","-H","77","-n","#CEFFAC","-h","#FFB6B0","-l","#96CBFE"] 36000,
        Run MultiCpu ["-t","<autototal>","-L","30","-H","60","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC","-w","3"] 10,
        Run Memory ["-t","<usedratio>%","-H","8192","-L","4096","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Network "wlp3s0" ["-t","<rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 10,
        Run Date "%m.%_d %k:%M" "date" 10,
	Run Battery ["-t", "<left>% (<timeleft>)", "-L", "10", "-H", "80", "-p", "3", "--", "-O", "<fc=green>On</fc> - ",
		     "-o", "", "-L", "-15", "-H", "-5", "-l", "red", "-m", "blue", "-h", "green"] 600,
	Run Brightness ["-t", "<percent>%"] 60,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %bright%   %battery% %multicpu%   %memory%   %wlp3s0%   <fc=#FFFFCC>%date%</fc>   %KPHX%"
}

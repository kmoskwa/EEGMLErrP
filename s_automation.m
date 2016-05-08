clear;
automation = 1;
for a = 3:100
    filterHi = a;% / 10.0;
    %filterLo = a / 10.0;
    eval(sprintf('postFix = ''_%i'';', a));
    s_main();
end

clear all;

el = [ 0.546299126418791   0.463136304556980   0.317163318737083   0.161069995570918   0.167963061739099 ];
ufl = [629.9471  611.6782  593.7855  526.7789  460.6394  399.2741];%nm
gaml = [6.5112    7.8116    6.2143   11.4325    7.5963    5.3239 ];
color = [ "red", "#ffa500", "#777777", "green", "#0027bd", "#a020f0"];

l_ = 1./ufl;

%plot(l_(1:length(el)), el, 'o--', Color = '#0027BD');
for i = 1:length(el)
    plot(ufl(i), el(i), 'o', Color = color(i));
    if i == 1
        hold on
    end
end

plot(ufl(1:length(el)), el, '--', Color = 'magenta');


names = ["Absorbance data", repelem("", length(el)-1), "Connecting Line"];
legend(names, Location = "northwest");
grid on;
grid minor;
title('Absorbance Spectra of E133 food dye');
ylabel('Absorbance [a.u.]');
xlabel('Wavelength [nm]');

fontsize(14, "points");


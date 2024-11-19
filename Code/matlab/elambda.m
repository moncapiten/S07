clear all;

el = [ 0.546299126418791   0.463136304556980   0.317163318737083   0.161069995570918   0.167963061739099 0.354317984428428];
ufl = [629.9471  611.6782  593.7855  526.7789  460.6394  399.2741];%nm
gaml = [6.5112    7.8116    6.2143   11.4325    7.5963    5.3239 ];
color = [ "red", "#ffa500", "#777777", "green", "#0027bd", "#a020f0"];

E133 = readmatrix('../../Data/Extra/E133_spettroLargo2.csv');
u133 = E133(:, 1);
a133 = E133(:, 2);

fructose = readmatrix('../../Data/Extra/fructose.csv');
ufr = fructose(:, 1);
afr = fructose(:, 2);

glucose = readmatrix('../../Data/Extra/glucose.csv');
ugl = glucose(:, 1);
agl = glucose(:, 2);



l_ = 1./ufl;

%plot(l_(1:length(el)), el, 'o--', Color = '#0027BD');
for i = 1:length(el)
    plot(ufl(i), el(i), 'o', Color = color(i));
    if i == 1
        hold on
    end
end

plot(ufl(1:length(el)), el, '-', Color = 'magenta');
hold on
plot(u133, a133, '.--', Color = 'red');
plot(ufr, afr, '-.', Color = 'green');
plot(ugl, agl, '--', Color = 'blue');


names = ["Absorbance data", repelem("", length(el)-1), "Connecting Line", "E133", "Fructose", "Glucose"];
legend(names, Location = "northwest");
grid on;
grid minor;
title('Absorbance Spectra of E133 food dye');
ylabel('Absorbance [a.u.]');
xlabel('Wavelength [nm]');

fontsize(14, "points");


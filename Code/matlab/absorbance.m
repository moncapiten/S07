clear all;

dataPosition = '../../Data/';
foldernames = [ "000%", "025%", "050%", "075%", "100%" ];
filenames = [ "1", "2", "3", "4", "5", "6" ];
names = [ "red", "orange", "yellow", "green", "blue", "purple"];

I0 = [ 1.1732e-05   5.0616e-06    4.3650e-06    2.4263e-05  2.7021e-05 1.0055e-04];
s_I0 = [ 2.7138e-07   1.1083e-07  1.9941e-07  3.1260e-07  2.6689e-07 9.6368e-06];

LED_number = 5;



A = [];
s_A = [];



for i = 1:5
    for j = 1:LED_number

        thr1 = 2.95;
        thr2 = 3.8;
        Rph = 221.72e3;
        if j == 4
            thr1 = 2.3;
            thr2 = 3.1;
            Rph = 100.3e3;
        elseif j == 5
            thr1 = 2.0;
            thr2 = 2.8;
            Rph = 100.3e3;
        elseif j == 6
            thr1 = 1.85;
            thr2 = 2.6;
            Rph = 22.131e3;
        end

        rawData = readmatrix(strcat(dataPosition, foldernames(i), "/data00", filenames(j), ".txt"));

        vw = rawData(:, 1);
        vph = rawData(:, 2);
        
        swapa = [];
        swapb = [];
        for k = 1:length(vw)
            if vw(k) > thr1 && vw(k) < thr2
                swapa(end+1) = vw(k);
                swapb(end+1) = vph(k);
            end
        end
        vw = swapa;
        vph = swapb;

        Ip = mean(vph) / Rph;
        s_Ip = std(vph) / mean(vph) * Ip / sqrt(length(vph));

        if i == 1
            I0(j) = Ip;
            s_I0(j) = s_Ip;
        end

        a = Ip / I0(j);
%        s_a = sqrt( (s_Ip / Ip)^2 + (s_I0(j) / I0(j))^2 ) * a;
        s_a = (s_Ip / Ip + s_I0(j) / I0(j)) * a;
        format long
        A(end+1) = -log10(a);
        s_A(end+1) = s_a/ ( a * log(10) );
    end
    A
end

function y = lin(params, x)
    y = params(1) * x * 1.22;
end

el = [];
cc = [ 0, 0.25, 0.5, 0.75, 1 ];
color = [ "red", "#ffa500", "#777777", "green", "#0027bd", "#a020f0"];
for i = 1:LED_number %led
    swapA = [];
    swapSA = [];
    for j = 1:5 %concentration
        swapA(end+1) = A(LED_number*(j-1)+i);
        swapSA(end+1) = s_A(LED_number*(j-1)+i);
    end
%    plot(cc, swapA, '--', Color = color(i));
    errorbar(cc, swapA, swapSA, 'o', Color = color(i));
    if i == 1
        hold on
    end
    [beta, R, ~, covbeta] = nlinfit(cc, swapA, @lin, [1]);
    plot(cc, lin(beta, cc), '-', Color = color(i));

    el(end+1) = beta(1);

    k = 0;
    for j = 1:length(R)
        k = k + ( R(j)/swapSA(j) )^2;
    end
    k/(length(R) -1)


end



el

legend("absorbance data","fit", Location = "northwest");
grid on;
grid minor;
title('Absorbance on different concentrations');
ylabel('Absorbance [a.u.]');
xlabel('Concentration ');




fontsize(14, "points");
















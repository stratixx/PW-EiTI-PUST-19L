% Plik:			exporter.m
% Autor:		Konrad Winnicki
% E-mail:		konrad_winnicki@wp.pl
% Przedmiot:	PUST
% Semestr:		19L
% Opis: Skrypt eksportujacy wyliczone parametry regulatora DMC do postaci
% zgodnej ze standardem jezyka ST

% powstanie plik "DMC_data.h" w folderze Inc
fileID = fopen('DMC_data.st','w');

fprintf(fileID,'//Parametry regulatora DMC1\n');
fprintf(fileID,'DMC_G1.D_ := %d;\n', D1);
fprintf(fileID,'DMC_G1.N_ := %d;\n', N1);
fprintf(fileID,'DMC_G1.Nu := %d;\n', Nu1);
fprintf(fileID,'DMC_G1.lambda := %f;\n\n', lambda1);

fprintf(fileID,'//Parametry regulatora DMC2\n');
fprintf(fileID,'DMC_G2.D_ := %d;\n', D2);
fprintf(fileID,'DMC_G2.N_ := %d;\n', N2);
fprintf(fileID,'DMC_G2.Nu := %d;\n', Nu2);
fprintf(fileID,'DMC_G2.lambda := %f;\n\n', lambda2);

fprintf(fileID,'// Przeliczone wartosci do sterowania DMC1\n');
fprintf(fileID,'DMC_G1.Ke := %f;\n\n', Ke1);
fprintf(fileID,'// Przeliczone wartosci do sterowania DMC2\n');
fprintf(fileID,'DMC_G2.Ke := %f;\n\n', Ke2);

for n=1:length(Ku1)    
    fprintf(fileID,'DMC_G1.Ku[%d] := %f;\n', n-1, Ku1(n));
end
fprintf(fileID,'\n');
    
for n=1:length(Ku2)    
    fprintf(fileID,'DMC_G2.Ku[%d] := %f;\n', n-1, Ku2(n));
end
fprintf(fileID,'\n');

for n=1:length(Ku1)    
    fprintf(fileID,'DMC_G1.delta_u_past[%d] := %f;\n', n-1, 0.0);
end
fprintf(fileID,'\n');

for n=1:length(Ku2)    
    fprintf(fileID,'DMC_G2.delta_u_past[%d] := %f;\n', n-1, 0.0);
end
fprintf(fileID,'\n');

fclose(fileID);

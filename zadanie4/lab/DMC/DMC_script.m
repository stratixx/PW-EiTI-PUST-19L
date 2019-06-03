% Plik:			DMC_script.m
% Autor:		Konrad Winnicki
% E-mail:		konrad_winnicki@wp.pl
% Przedmiot:	PUST
% Semestr:		19L
% Opis:			Skrypt wyliczający parametry regulatora DMC
%				przeznaczonego do uruchomienia w systemie wbudowanym

% Założone parametry regulatora
lam = 1
load('../zad1/esy/s1.mat')
s = s1aprox;
D1 = length(s); % horyzont dynamiki
N1=D1;
Nu1=N1;
lambda1 = lam;
D = D1; % horyzont dynamiki
N=N1;
Nu=Nu1;
lambda = lambda1;
run('DMC_init.m');

Ke1 = sum(K(1,:));
Ku1 = K(1,:)*Mp;

load('../zad1/esy/s2.mat')
s = s2aprox;
D2 = length(s); % horyzont dynamiki
N2=D2;
Nu2=N2;
lambda2 = lam;
D = D2; % horyzont dynamiki
N=N2;
Nu=Nu2;
lambda = lambda2;
run('DMC_init.m');

Ke2 = sum(K(1,:));
Ku2 = K(1,:)*Mp;

% wyeksportowanie wyznaczonych parametrów do pliku nagłówkowego zgodnego ze standardem języka C
run('exporter.m');

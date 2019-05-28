%clear
load('../processed/zlozone.mat');
daneDynUczU1 = u1_real;
daneDynUczU2 = u2_real;
daneDynUczY = y1_real;
load('../processed/noweSkokiCo120s.mat');
daneDynWerU1 = u1_real;
daneDynWerU2 = u2_real;
daneDynWerY = y1_real;
dataLength = length(daneDynUczU1);
dataVerifLength = length(daneDynWerU1);
%clear daneDynUcz daneDynWer

 daneDynUczU1 = (daneDynUczU1 - mean(daneDynUczU1(1:22)))/15;
 daneDynUczU2 = (daneDynUczU2 - mean(daneDynUczU2(1:22)))/15;
 daneDynUczY = (daneDynUczY - mean(daneDynUczY(1:22)))/15;
 daneDynWerU1 = (daneDynWerU1 - mean(daneDynWerU1(1:22)))/15;
 daneDynWerU2 = (daneDynWerU2 - mean(daneDynWerU2(1:22)))/15;
 daneDynWerY = (daneDynWerY - mean(daneDynWerY(1:22)))/15;

configuration = 'u12y1';
Nmax = 29;
Na=7;
Nb=Na;
N=0;
minErrVerify = 100000.0;
minErrVerifyN = 1000;
minErrDelta = 1000;
errArray = zeros(Nmax,3);

for Na=5:1:Nmax
    Na
    Nb=Na
    errArray(Na, 1) = Na;
    
    Mlearn = ones(dataLength-max([Na,Nb]), 2*Na+Nb);
    
    %u1
    for n=0:1:(Na-1)
        Mlearn(:,n+1) = daneDynUczU1( (max([Na,Nb])-n):(end-n-1) );
    end
    
    %u2
    for n=0:1:(Na-1)
        Mlearn(:,Na+n+1) = daneDynUczU2( (max([Na,Nb])-n):(end-n-1) );
    end
    
    for n=(0):1:(Nb-1)
        Mlearn(:,2*Na+n+1) = daneDynUczY( (max([Na,Nb])-n):(end-n-1) );
    end
    
    Wlearn = Mlearn\daneDynUczY(max([Na,Nb]+1):end);
    
    YlearnCalc = daneDynUczY';
    
    for k=Na+1:1:length(YlearnCalc)
       YlearnCalc(k)= [ flip(daneDynUczU1(k-Na:k-1)'), flip(daneDynUczU2(k-Na:k-1)'), flip(YlearnCalc(k-Na:k-1)) ] * Wlearn; 
    end
    
    errLearn = (sum(power( daneDynUczY(max([Na,Nb]+1):end)-YlearnCalc(1+Na:end)', 2 )));
    errLearn = errLearn / dataLength * 1e5;
    errArray(Na, 2) = errLearn;
    
    Mverif = ones(dataVerifLength-max([Na,Nb]), 2*Na+Nb);
    %u1
    for n=0:1:(Na-1)
        Mverif(:,n+1) = daneDynWerU1( (max([Na,Nb])-n):(end-n-1) );
    end
    
    %u2
    for n=0:1:(Na-1)
        Mverif(:,Na+n+1) = daneDynWerU2( (max([Na,Nb])-n):(end-n-1) );
    end
    
    %y
    for n=(0):1:(Nb-1)
        Mverif(:,2*Na+n+1) = daneDynWerY( (max([Na,Nb])-n):(end-n-1) );
    end
    
    %Wverif = Mverif\daneDynWerY(max([Na,Nb]+1):end);
    YverifCalc = daneDynWerY';
    
    for k=Na+1:1:length(YverifCalc)
       YverifCalc(k)= [ flip(daneDynUczU1(k-Na:k-1)'), flip(daneDynUczU2(k-Na:k-1)'), flip(YverifCalc(k-Na:k-1)) ] * Wlearn; 
    end
    
    errVerif = (sum(power( daneDynWerY(max([Na,Nb]+1):end)-YverifCalc(1+Na:end)', 2 )));
    errVerif = errVerif / dataVerifLength * 1e5;
    errArray(Na, 3) = errVerif;
    
    if errVerif<(minErrVerify-minErrDelta)
        minErrVerify = errVerif;
        minErrVerifyN = Na;
    end
    %continue
    figure(1)
    
    subplot(2,1,1)
    hold on; grid on; box on;
    plot( daneDynUczY, '.');
    plot( YlearnCalc);
    title(strcat('Model dynamiczny na tle zbioru danych ucz¹cych, Nb=Na=',num2str(Na),', err=',num2str(errLearn)));
    %xlabel('Próbki');
    ylabel('Sygna³ wyjœciowy y');
    legend('Dane ucz¹ce','Wyjœcie modelu','location','southeast')
    %print(strcat('img/bc/recur/learn/learn_Nb_',num2str(Nb),'_Na_',num2str(Na)), '-dpng');
    %close 1;
    
    %figure(2)
    subplot(2,1,2)
    hold on; grid on; box on;
    plot( daneDynWerY, '.');
    plot( YverifCalc);
    title(strcat('Model dynamiczny na tle zbioru danych weryfikuj¹cych, Nb=Na=',num2str(Na),', err=',num2str(errVerif)));
    xlabel('Próbki');
    ylabel('Sygna³ wyjœciowy y');
    legend('Dane weryfikuj¹ce','Wyjœcie modelu','location','southeast')
    print(strcat('img/modelReccur/',configuration,'/Nb_',num2str(Nb),'_Na_',num2str(Na)), '-dpng');
    close 1;
end

errArray
display( strcat( 'Wybrany model: N= ', num2str(minErrVerifyN), '; errVerif= ', num2str(minErrVerify) ) );

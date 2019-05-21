%clear

daneDynUczU = u2;
daneDynUczY = y2;
daneDynWerU = u2;
daneDynWerY = y2;
dataLength = length(daneDynUczU);
%clear daneDynUcz daneDynWer

daneDynUczU = (daneDynUczU - mean(daneDynUczU(1:50)))/15;
daneDynUczY = (daneDynUczY - mean(daneDynUczY(1:50)))/15;
daneDynWerU = (daneDynWerU - mean(daneDynWerU(1:50)))/15;
daneDynWerY = (daneDynWerY - mean(daneDynWerY(1:50)))/15;

configuration = 'u2y2';
Nmax = 2;
Na=7;
Nb=Na;
N=0;
minErrVerify = 100000.0;
minErrVerifyN = 1000;
minErrDelta = 1000;
errArray = zeros(Nmax,3);

for Na=2:1:Nmax
    Na
    Nb=Na
    errArray(Na, 1) = Na;
    
    Mlearn = ones(dataLength-max([Na,Nb]), Na+Nb);
    
    for n=0:1:(Na-1)
        Mlearn(:,n+1) = daneDynUczU( (max([Na,Nb])-n):(end-n-1) );
    end
    
    for n=(0):1:(Nb-1)
        Mlearn(:,Na+n+1) = daneDynUczY( (max([Na,Nb])-n):(end-n-1) );
    end
    
    Wlearn = Mlearn\daneDynUczY(max([Na,Nb]+1):end);
    
    YlearnCalc = daneDynUczY';
    
    for k=Na+1:1:length(YlearnCalc)
       YlearnCalc(k)= [ flip(daneDynUczU(k-Na:k-1)'), flip(YlearnCalc(k-Na:k-1)) ] * Wlearn; 
    end
    
    errLearn = (sum(power( daneDynUczY(max([Na,Nb]+1):end)-YlearnCalc(1+Na:end)', 2 )));
    errLearn = errLearn / dataLength * 100;
    errArray(Na, 2) = errLearn;
    
    Mverif = ones(dataLength-max([Na,Nb]), Na+Nb);
    for n=0:1:(Na-1)
        Mverif(:,n+1) = daneDynWerU( (max([Na,Nb])-n):(end-n-1) );
    end
    
    for n=(0):1:(Nb-1)
        Mverif(:,Na+n+1) = daneDynWerY( (max([Na,Nb])-n):(end-n-1) );
    end
    
    %Wverif = Mverif\daneDynWerY(max([Na,Nb]+1):end);
    YverifCalc = daneDynWerY';
    
    for k=Na+1:1:length(YverifCalc)
       YverifCalc(k)= [ flip(daneDynUczU(k-Na:k-1)'), flip(YverifCalc(k-Na:k-1)) ] * Wlearn; 
    end
    
    errVerif = (sum(power( daneDynWerY(max([Na,Nb]+1):end)-YverifCalc(1+Na:end)', 2 )));
    errVerif = errVerif / dataLength * 100;
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

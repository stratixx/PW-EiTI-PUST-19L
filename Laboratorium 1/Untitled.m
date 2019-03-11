
addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port


Tp = 1; % czas z jakim probkuje regulator
y = ones(1,1000)*36.87; % wektor wyjsc obiektu
y_zad = zeros(1,1000); % wektor wyjsc zadanych obiektu
u = ones(1,1000)*32; % wektor wejsc (sterowan) obiektu
Y = 0;
Yzad=0;
U=0;
k = 1;
while true % zbieramy 1000 pomiarow
 
%% obtaining measurements
measurements = readMeasurements (1:7) ; % read measurements
    
    y(end)=measurements(1); % powiekszamy wektor y o element Y
   %% y_zad(end)=Yzad; % powiekszamy wektor y o element Y
   if(k<300)
    u(end)=32; % powiekszamy wektor u o element U
   else u(end)=55;
   end
    figure(1);
    clf(1);
    hold on;
    title('y');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(y); % wyswietlamy y w czasie
   %% plot(y_zad); % wyswietlamy y w czasie
    %legend('y','y_z_a_d')
    
    figure(2); 
    clf(2);
    hold on;
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
    plot(u); % wyswietlamy u w czasie
    %legend('u')
    
    drawnow
    
    
 %% sending new values of control signals
sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , u(end) , 0]) ;
    
%% synchronising with the control process
waitForNewIteration () ; % wait for new iteration

    y = circshift(y,[0,-1]);
   %% y_zad = circshift(y_zad,[0,-1]);
    u = circshift(u,[0,-1]);
k=k+1;
end

figure; plot((0:(length(y)-1))*Tp,y); % wyswietlamy y w czasie
figure; plot((0:(length(u)-1))*Tp,u); % wyswietlamy u w czasie

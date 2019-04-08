addpath ('F:\SerialCommunication') ; % add a path
initSerialControl COM5 % initialise com port

k = 1;
kk = 1000;
u(1:200,1) = 32;
u(200:1000,1) = 20;
y = ones(1,kk)*8+20;
yzad = u; % wektor wartosc zadanych

sendControls ([ 1 , 2 , 3 , 4 , 5 , 6] ,    [ 50 , 0 , 0 , 0 , 0 , 0]) ;
while k < kk
measurements = readMeasurements (1:7) ; % read measurements
    
    y(end)=measurements(1); % powiekszamy wektor y o element Y
	
    sendNonlinearControls(u(k));
    
    figure(1);
    clf(1);
    hold on;
    plot(y(1:k)); % wyswietlamy y w czasie
    plot(yzad(1:k)); % wyswietlamy yzad w czasie
    title('y y_z_a_d');
    grid on;
    xlabel('time');
    ylabel('value');
   % xlim([offset (ceil((k-offset+1)/100)*100)]);
    %legend('y')
    
    figure(2); 
    clf(2);
    hold on;
    plot(u(1:k)); % wyswietlamy u w czasie
    title('u');
    grid on;
    xlabel('time');
    ylabel('value');
  %  xlim([offset (ceil((k-offset+1)/100)*100)]);
    %legend('u')
    
    drawnow
    
    
    %% synchronising with the control process
    waitForNewIteration () ; % wait for new iteration
    pause(0.05);
    k=k+1;
end
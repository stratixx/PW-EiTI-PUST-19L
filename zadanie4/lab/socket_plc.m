%%Socket Communication demo script
delete(instrfindall)
pause(2);

close all;
clear all; 
  
t = tcpip('192.168.127.250',4000, 'NetworkRole', 'client');

t.OutputBufferSize = 3000;
t.InputBufferSize = 3000;
 
fopen(t);
u1 = [];
u2 = [];
y1 = [];
y2 = [];
yz1 = [];
yz2 = [];


w1=[];
w2=[];
w3=[];
w4=[];
g1=[];
g2=[];
t1=[];
t2=[];
t3=[];

figure(1);
while (length(y1) < 100)
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t);
        disp(temp);
        eval(temp);
        
        
        w1 = [w1; W1];
        w2 = [w2; W2];
        w3 = [w3; W3];
        w4 = [w4; W4];
        g1 = [g1; G1];
        g2 = [g2; G2];
        t1 = [t1; T1];
        t2 = [t2; T2];
        t3 = [t3; T3];
        
        y1 = t1;
        y2 = t2;
        
        u1 = g1;
        u2 = g2;
     
        
        subplot(2,1,1); plot(y1); hold on; plot(y2); hold off; title('Wyjœcie'); xlabel('iteracja');
        subplot(2,1,2); stairs(u1); hold on; stairs(u2); hold off; title('Sterowanie'); xlabel('iteracja');
        drawnow
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;


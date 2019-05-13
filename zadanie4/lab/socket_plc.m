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
k=[];

figure(1);
while (length(g1) < 10000)
    if (t.BytesAvailable ~= 0)
        temp = fscanf(t);
        disp(temp);
        eval(temp);
        
        
%         w1 = [w1; W1];
%         w2 = [w2; W2];
%         w3 = [w3; W3];
%         w4 = [w4; W4];
        g1 = [g1; G1];
        g2 = [g2; G2];
        t1 = [t1; T1];
        t2 = [t2; T2];
         t3 = [t3; T3];
         k=[k;K];
        
        y1 = t1/100;
        y2 = t3/100;
        
        u1 = g1/10;
        u2 = g2/10;
     
        
        subplot(2,1,1); 
        stairs(y1); 
        hold on; 
        stairs(y2); 
        hold off; 
        title('Wyjœcie'); 
        xlabel('iteracja');
        legend('T1', 'T3');
        
        subplot(2,1,2); 
        stairs(u1); 
        hold on; 
        stairs(u2); 
        hold off; 
        title('Sterowanie'); 
        xlabel('iteracja');
        legend('G1', 'G2');
        
        drawnow
    end
    pause(0.05);
end

fclose(t);
delete(t);
clear t;


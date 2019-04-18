function [D,N,Nu,lambda] = nastawy_DMC(n)

if n == 2
    D = [70, 30];
    N = [70, 20];
    Nu = [30, 5];
    lambda =[1, 1];
end

if n == 3
    D = [70, 70,30];
    N = [70, 70,20];
    Nu = [6, 8,5];
    lambda =[1, 1, 1];
end

if n == 4
    D = [70,70, 30,30];
    N = [70,50, 25,25];
    Nu = [5, 7, 10,10];
    lambda =[1,1, 1,1];
end

if n == 5
    D = [70,30,30,30,30];
    N = [70,18,25,25,25];
    Nu = [5, 16,6,10,10];
    lambda =[1,1,1,1,1];
end
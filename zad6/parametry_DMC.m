function [Mp,K,u_delta] = parametry_DMC(D,N,Nu,fuzzyN,k)
lambda = 1;
if k == 1
    load('s21.mat')
end
if k == 2
    load('s22.mat')
end
Mp = zeros(N,D - 1);
for i = 1:N
   for j = 1:D - 1
      if i+j <= D
         Mp(i,j) = s(i+j)-s(j);
      else
         Mp(i,j) = s(D)-s(j);
      end      
   end
end
M = zeros(N,Nu);
for i = 1:N
for j = 1:Nu
  if (i >= j)
     M(i,j) = s(i-j+1);
  end
end
end
mac_lam = lambda*eye(Nu);
psi = eye(N);
K = ((M'*psi*M+mac_lam)^(-1))*M'*psi;
u_delta = zeros(1,D - 1);
end
function [w] = fuzzyFun(Y, file)


load(file);
w=[];
for k=1:length(Y)
    data = [abs(U-Y(k))];

    [sorted ind] = sort(data);

    w = [ w [w1(ind(1)); w2(ind(1)); w3(ind(1))] ];
end
end


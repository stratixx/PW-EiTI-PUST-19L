output = y;
input = u;

stepStart = 317;
stepEnd = 1000;

s = output(stepStart:stepEnd);
u_ = input(stepStart:stepEnd);

s = s - output(stepStart-1);
u_ = u_ - input(stepStart-1);

s = s ./ u_(end);
u_ = u_ ./ u_(end);

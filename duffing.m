function dx = duffing(t,x)

dx = [
    x(2);
    -0.2*x(2) + x(1) - x(1)^3 + 0.33*cos(t);
    ];
function dx = lorenz(t,x)

% x(1) = x;
% x(2) = y;
% x(3) = z;

dx = [
    (-8/3)*x(1) + x(2)*x(3);
    -10*(x(2) - x(3));
    -x(1)*x(2) + 28*x(2) - x(3);
    ];
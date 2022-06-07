function Xfnn = FNN_KennelFraction(minDim, maxDim, tau, ts, Rtol,Atol)

% Function provided by Professor Dr. Firas Khasawneh (05/10/2022)
% Minor changes and comments have been made to the code for study purposes

% If no threshold was given, use the default value
if nargin < 5
    Rtol = 10;
end

if nargin < 6
    Atol = 2;
end

% if the least # of points in the reconstructed space is less than 20
if length(ts) - (maxDim - 1) * tau < 20
    maxDim = length(ts) - (maxDim-1) * tau - 1; % 
end

ts = ts(:); % make sure ts is a column vector.
st_dev = std(ts); % Find the standard deviation of the data

ndim = max(1,maxDim - minDim+1); % # of dimensions to test

Xfnn = zeros(1,ndim); % Vector to store the fnn ratios
for i = 1:ndim + 1
    dim = i;
    
    % Delay reconstruction
    xlen = length(ts) - (dim-1) * tau; % #of rows of reconstructed space
    a = 1:xlen;
    delayVec = (0:(dim-1))*tau;
    delayMat = repmat(delayVec,[xlen, 1]);
    vec = repmat(a(:),[1, dim]);
    %indRecon = reshape(vec,[xlen,dim]) + delayMat;
    indRecon = vec + delayMat; % indices of reconstructed state space
    tsRecon  = ts(indRecon); % Reconstructed state space
    
    % The row i of IDX has the 2 rows numbers of tsRecon which are closest
    % to row i in tsRecon (D stores the distances in ascending order)
    [IDX,D] = knnsearch(tsRecon,tsRecon,'k',2); % find the closest two points to each point in Y
    
    % Calculate the false nearest neighbor ratio for each dimension
    if i > 1
        D_mp1 = sqrt(sum((tsRecon(ind_m,:)-tsRecon(ind,:)) .^2,2)); % sqrt(epsilon_i^2 + delta_i^2)
        
        % Criteria #1: increase in distance between neighbors is large
        num1 = heaviside(abs(tsRecon(ind_m,end) - tsRecon(ind,end)) ./ Dm - Rtol);% delta_i > r*epsilon_i
        
        % Criteria #2: distance in (d+1)-dimension is large
        num2 = heaviside(D_mp1/st_dev - Atol); % epsilon_i^2 + delta_i^2 > sigma^2*a^2

        num  = (num1 + num2);
        c = num > 1;
        num(c) = 1;
        num = sum(num);
        den = length(ind_m);
        
        Xfnn(i-1) = (num/den) * 100; % Percent of false nearest neighbors
    end
    % Save the index to D and k(n) in dimension m for comparison with the
    % same distance in m+1 dimension
    xlen2 = length(ts) - dim * tau; % # of points in (d+1)-dimension
    Dm    = D(1:xlen2,end); % The distance bewteen n and k(n) in m dimension
    ind_m = IDX(1:xlen2,end); % index to nearest neighbor in m dimension
    
    % Remove indices of elements whose nearest neighbor is outside the
    % reconstructed signal in m+1
    ind = ind_m <= xlen2;
    ind_m = ind_m(ind);
    Dm = Dm(ind); 
end

end
function Xfnn = FNN_Abarbanel(minDim, maxDim, tau, ts, Rtol,Atol)

% Function provided by Professor Dr. Firas Khasawneh (05/10/2022)
% Minor changes and comments have been made to the code for study purposes

% If no threshold was given, use the default value
if nargin < 5
    Rtol = 10;
end

if nargin < 6
    Atol = 2;
end

% 
if length(ts) - (maxDim - 1) * tau < 20
    maxDim = length(ts) - (maxDim-1) * tau - 1;
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
    indRecon = reshape(vec,[xlen,dim]) + delayMat; % indices of reconstructed state space
    tsRecon  = ts(indRecon); % Reconstructed state space
    
    [IDX,D] = knnsearch(tsRecon,tsRecon,'k',2); % find the closest two points to each point in Y
    
    % Calculate the false nearest neighbor ratio for each dimension
    if i > 1
        D_mp1 = sqrt(sum((tsRecon(ind_m,:)-tsRecon(ind,:)) .^2,2)); % Distance between n and k(n) in m+1 dimensions
        
        % Criteria #1: increase in distance between neighbors is large
        num1 = heaviside(abs(tsRecon(ind_m,end) - tsRecon(ind,end)) ./ Dm - Rtol);% increase in distance in going from dimension m to m+1
        
        % Criteria #2: nearest neighbor not necessarily close to y(n)
        num2 = heaviside(Atol -  D_mp1/st_dev);

        num  = sum(num1 .* num2);
        den = sum(num2);
        
        Xfnn(i-1) = num/den * 100; % Percent of false nearest neighbors
    end
    % Save the index to D and k(n) in dimension m for comparison with the
    % same distance in m+1 dimension
    xlen2 = length(ts) - dim * tau;
    Dm    = D(1:xlen2,end); % The distance bewteen n and k(n) in m dimension
    ind_m = IDX(1:xlen2,end); % index to nearest neighbor in m dimension
    
    % Remove indices of elements whose nearest neighbor is outside the
    % reconstructed signal in m+1
    ind = ind_m <= xlen2;
    ind_m = ind_m(ind);
    Dm = Dm(ind); 
end
end
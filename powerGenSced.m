clear; % Clear all variables and functions from memory

n = 2;
P_alpha = 237.07;
a = [0.02, 0.04];
b = [162, 20];

Lambda = 20;
Lambda_prev = Lambda;

C_eps = 1;

delta_Lambda = 0.01; % Smaller step size for Lambda adjustment

Pg_max = [200, 200];
Pg_min = [0, 0];

B = [0.001, 0.001; 0.001, 0.001]; % Updated for the correct size

Pg = zeros(n, 1);

no_filter = 0;
P_L = 0;

Pg = zeros(n, 1);

Pd = 100; % Assuming a demand power value

maxIter = 100; % Set a maximum number of iterations
iter = 0; % Initialize iteration counter

% Iteration to adjust the power generation Pg
while abs(sum(Pg) - Pd - P_L) > C_eps && iter < maxIter
    for i = 1:n
        Sigma = B(i, :) * Pg - B(i, i) * Pg(i);
        Pg(i) = (1 - (b(i) / Lambda) - (2 * Sigma) / (a(i) + 2 * B(i, i)));
        
        % Enforce generation limits
        if Pg(i) > Pg_max(i)
            Pg(i) = Pg_max(i);
        elseif Pg(i) < Pg_min(i)
            Pg(i) = Pg_min(i);
        end
    end
    
    % Update Lambda after the loop
    Lambda = Lambda_prev + delta_Lambda * (Pd - sum(Pg));
    
    % Increment iteration counter
    iter = iter + 1;
end

% Display the result
disp('Power generation values Pg:');
disp(Pg);
disp(['Number of iterations: ', num2str(iter)]);

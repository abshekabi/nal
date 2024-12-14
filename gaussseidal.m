% Gauss-Seidel Method in a Single Script

% Define the coefficient matrix A and the right-hand side vector b
A = [5, 3, 1; 3,5,2; 1,2,5]
b = [18;28;35];

% Set tolerance and maximum number of iterations
tolerance = 1e-5;
maxIterations = 100;

% Initialize variables
n = length(b);
x = zeros(n, 1); % Initial guess (zero vector)
x_old = x;

% Gauss-Seidel Iterative Process
for k = 1:maxIterations
    for i = 1:n
        % Sum of known terms
        sum1 = 0;
        sum2 = 0;
        
        for j = 1:i-1
            sum1 = sum1 + A(i, j) * x(j);
        end
        
        for j = i+1:n
            sum2 = sum2 + A(i, j) * x_old(j);
        end
        
        % Update the i-th component of x
        x(i) = (b(i) - sum1 - sum2) / A(i, i);
    end
    
    % Check for convergence
    if norm(x - x_old, inf) < tolerance
        fprintf('Converged in %d iterations\n', k);
        break;
    end
    
    x_old = x; % Update x_old for the next iteration
end

if k == maxIterations
    fprintf('Did not converge within %d iterations\n', maxIterations);
end

% Display the solution
disp('Solution:');
disp(x);

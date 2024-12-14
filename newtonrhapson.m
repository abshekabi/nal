syms x;

% Define the function
f_sym = x^2-3*x+1.06;
f = matlabFunction(f_sym);

% Calculate the derivative of the function symbolically
df_sym = diff(f_sym, x);
df = matlabFunction(df_sym);

% Initial guess
x0 = 1;

% Tolerance and maximum number of iterations
tol = 1e-6;
maxIter = 100;

% Initialize variables
iter = 0;
x_curr = x0;

% Newton-Raphson iteration
while iter < maxIter
    % Calculate the value of the function and its derivative at x
    fx = f(x_curr);
    dfx = df(x_curr);
    
    % Update the current value using the Newton-Raphson formula
    x_new = x_curr - fx / dfx;
    
    % Check for convergence
    if abs(x_new - x_curr) < tol
        break;
    end
    
    % Update the current value and iteration counter
    x_curr = x_new;
    iter = iter + 1;
end

% Assign the root
root = x_curr;

% Display the result
disp(['The root is: ', num2str(root)]);

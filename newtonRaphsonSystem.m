function newtonRaphsonSystem()
    % Define the system of equations and their Jacobian
    syms x1 x2;
    f1 = 4 * x2 * sin(x1) + 0.6;
    f2 = 4 * x2^2 - 4 * x2*cos(x1) + 0.3;
    
    F = [f1; f2]; % System of equations
    J = jacobian(F, [x1, x2]); % Jacobian matrix
    
    % Convert symbolic expressions to function handles
    F_fun = matlabFunction(F, 'Vars', [x1, x2]);
    J_fun = matlabFunction(J, 'Vars', [x1, x2]);
    
    % Initial guess
    x0 = [0.5; 0.5];
    
    % Tolerance and maximum number of iterations
    tol = 1e-6;
    maxIter = 100;
    
    % Initialize variables
    iter = 0;
    x = x0;
    
    % Small perturbation to avoid singular Jacobian
    epsilon = 1e-8;
    
    % Newton-Raphson iteration
    for iter = 1:maxIter
        % Evaluate the function and Jacobian at the current point
        F_val = F_fun(x(1), x(2));
        J_val = J_fun(x(1), x(2));
        
        % Add small perturbation to Jacobian to avoid singularity
        J_val = J_val + epsilon * eye(size(J_val));
        
        % Debugging output
        disp(['Iteration: ', num2str(iter)]);
        disp(['x1: ', num2str(x(1)), ', x2: ', num2str(x(2))]);
        disp(['F(x): ', num2str(F_val(1)), ', ', num2str(F_val(2))]);
        disp(['Jacobian: ', num2str(J_val(1,1)), ', ', num2str(J_val(1,2)), ', ', num2str(J_val(2,1)), ', ', num2str(J_val(2,2))]);
        
        % Update the current value using the Newton-Raphson formula
        x_new = x - J_val \ F_val;
        
        % Check for convergence
        if norm(x_new - x) < tol
            break;
        end
        
        % Update the current value
        x = x_new;
    end
    
    % Display the result
    disp(['The solution is: x1 = ', num2str(x(1)), ', x2 = ', num2str(x(2))]);
end

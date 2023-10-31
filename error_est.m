% Define the integrable function (f(x) = cos(x))
func = @(x) cos(x);

% Define the integration limits
a = 0;  % Lower limit
b = 5;  % Upper limit

% Define a range of values for n
%n_values = [10, 20, 50, 100, 200, 500];
n_values = [2, 4, 8, 16, 32, 64, 128, 256, 512];

% Number of runs to average over
k = 10;

% Initialize an array to store the average errors
average_errors = zeros(size(n_values));

% Calculate the true value of the integral
true_value = double(sin(b) - sin(a));

% Measure the runtime and calculate the errors for each value of n for k runs
for i = 1:length(n_values)
    n = n_values(i);
    errors = zeros(1, k);
    
    for j = 1:k
        % Perform midpoint integration
        estimated_value = midpoint_integration(func, a, b, n);
        
        % Calculate the absolute error
        errors(j) = abs(true_value - estimated_value);
    end
    
    % Calculate the average error for this value of n
    average_errors(i) = mean(errors);
end

% Plot the results with logarithmic scales on both axes
loglog(n_values, average_errors, '-o');
xlabel('Log(n) (Number of Subintervals)');
ylabel('Log(Average Absolute Error)');
title(['Average Error vs. Log(n) (', num2str(k), ' runs per n)']);


function result = midpoint_integration(func, a, b, n)
    % func: The function to be integrated
    % a: The lower limit of integration
    % b: The upper limit of integration
    % n: The number of subintervals
    
    % Calculate the width of each subinterval
    h = (b - a) / n;
    
    % Initialize the result
    result = 0;
    
    % Perform the mid-point integration
    for i = 1:n
        % Calculate the midpoint of the current subinterval
        x_mid = a + (i - 0.5) * h;
        
        % Evaluate the function at the midpoint and add to the result
        result = result + func(x_mid);
    end
    
    % Multiply by the width of the subintervals to get the final result
    result = h * result;
end
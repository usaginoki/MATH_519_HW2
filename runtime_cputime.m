% Define the integrable function (f(x) = cos(x))
func = @(x) cos(x);

% Define the integration limits
a = 0;  % Lower limit
b = 5;  % Upper limit

% Define a range of values for n
n_values = [10, 20, 50, 100, 200, 500];

% Number of runs to average over
k = 2^17;

% Initialize an array to store the average runtimes
average_runtimes = zeros(size(n_values));

% Measure the runtime for each value of n for k runs
for i = 1:length(n_values)
    n = n_values(i);
    runtimes = zeros(1, k);
    for j = 1:k
        % Calculate the runtime
        runtimes(j) = measureRuntime(@() midpoint_integration(func, a, b, n));
    end
    
    % Calculate the average runtime for this value of n
    %average_runtimes(i) = (end_time - start_time)/k;
    average_runtimes(i) = mean(runtimes);
end

% Plot the results with logarithmic scales on both axes
loglog(n_values, average_runtimes, '-o');
xlabel('Log(n) (Number of Subintervals)');
ylabel('Log(Average Runtime) (seconds)');
title(['Average Runtime vs. Log(n) (', num2str(k), ' runs per n)']);

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

function executionTime = measureRuntime(func)
    % func: The function you want to measure the runtime of
    
    % Record the start time
    startTime = cputime;
    
    % Call the function
    func();
    
    % Record the end time
    endTime = cputime;
    
    % Calculate the execution time
    executionTime = endTime - startTime;
    
    % Display the execution time
    %disp(['Execution time: ', num2str(executionTime), ' seconds']);
end
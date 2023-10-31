% Define the integrable function (f(x) = cos(x))
func = @(x) cos(x);

% Define the borders of the integral
a = 0;
b = 5;

% Claculate the true value of the integral
true_value = sin(b) - sin(a);

% Define a range of values for n
n_values = [10, 20, 50, 100, 200, 500];

% Number of runs to average over
k = 2^17;

% Initialize an array to store the average execution times
average_execution_times = zeros(size(n_values));

% Measure the runtime for each value of n for k runs and calculate the average
for i = 1:length(n_values)
    n = n_values(i);
    execution_times = zeros(1, k);
    for j = 1:k
        execution_times(j) = measureRuntime(@( ) midpoint_integration(func, a, b, n));
    end
    %Calculate the average execution time for this value of n
    average_execution_times(i) = mean(execution_times);
end

% Plot the results with logarithmic scales on both axes
loglog(n_values, average_execution_times, '-o');
xlabel('Log(n) (Number of Subintervals)');
ylabel('Log(Average Execution Time) (seconds)');
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
    startTime = tic;
    
    % Call the function
    func();
    
    % Record the end time
    endTime = toc(startTime);
    
    % Calculate the execution time
    executionTime = endTime;
    
    % Display the execution time
    %disp(['Execution time: ', num2str(executionTime), ' seconds']);
end



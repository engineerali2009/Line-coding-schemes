% Dr Ali Mohamed AbdelAziz
% 18 Oct 2023
% Matlab file
%% This version is better, tested and
% Data
%data = [1 1 0 1 1 0 0 0 0 0 0 0 0 1];
%data=[0 1 0 0 1 1 1 0];
%data=[0 1 0 0 1 0];
data=[1 1 0 0 1 0 1 0];


% Generate Square wave for the input data
[x_square, y_square] = GenerateSquareWave(data);

% Generate Unipolar Encoding
[x_unipolar, y_unipolar] = Unipolar(data);

% Generate NRZL Encoding
[x_nrzl, y_nrzl] = NRZL(data);

% Generate NRZI Encoding
[x_nrzi, y_nrzi] = NRZI(data);

% Generate Manchester Encoding
[x_manchester, y_manchester] = Manchester(data);

% Generate Differential Manchester Encoding
[x_diff_manchester, y_diff_manchester] = DifferentialManchester(data);



% Generate Pseudoternary Encoding
[x_Pseudoternary, y_Pseudoternary] = Pseudoternary(data);



% Generate polar RZ Encoding
[x_birz, y_birz] = Polar_RZ(data);



% Generate AMI_NRZ Encoding
   [x_Ami, y_Ami] = AMI(data);



% Plot
figure('Position', [100, 100, 800, 1200]); % x, y, width, height

% Plotting original data as a square wave
n = length(data);
x_square = [];
y_square = [];

for i = 1:n
    x_square = [x_square i-1 i];
    y_square = [y_square data(i) data(i)];
end

subplot(9,1,1);
plot(x_square, y_square, 'LineWidth', 2);

% Annotate the plot with the bit values from 'data' in bold and black
for i = 1:n
    text(i-0.5, 1.2, num2str(data(i)), 'FontWeight', 'bold', 'Color', 'red');
end

title('Original Data Square Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -0.5, 1.5]);
xticks(0:1:length(data)-1);


% Plotting Unipolar Encoding
subplot(9,1,2);
plot(x_unipolar, y_unipolar, 'LineWidth', 2);
title('Unipolar Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);



% Plotting  NRZL  Encoding
subplot(9,1,3);
plot(x_nrzl, y_nrzl, 'LineWidth', 2);
title('NRZL Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);




% Plotting  NRZI  Encoding
subplot(9,1,4);
plot(x_nrzi, y_nrzi, 'LineWidth', 2);
title('NRZI Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);


% Plotting  polar RZ  Encoding
subplot(9,1,5);
stairs(x_birz, y_birz, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('Polar RZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);

% Plotting Manchester Encoding
subplot(9,1,6);
plot(x_manchester, y_manchester, 'LineWidth', 2);
title('Manchester Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);

% Plotting Differential Manchester Encoding
subplot(9,1,7);
plot(x_diff_manchester, y_diff_manchester, 'LineWidth', 2);
title('Differential Manchester Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);





% Plotting  AMI   Encoding
subplot(9,1,8);
stairs(x_Ami, y_Ami, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('AMI Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);





% Plotting  Pseudoternary   Encoding
subplot(9,1,9);
stairs(x_Pseudoternary, y_Pseudoternary, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('Pseudoternary Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);




% Save plot in EPS format
saveas(gcf, 'test.eps', 'epsc')




function [x, y] = Unipolar(data)
    n = length(data);
    x = [];
    y = [];
    for i = 1:n
        x = [x i-1 i];
        y = [y data(i) data(i)];
    end
end

function [x, y] = GenerateSquareWave(data)
    n = length(data);
    x = [];
    y = [];
    for i = 1:n
        x = [x i-1 i];
        y = [y data(i) data(i)];
    end
end

function [x, y] = NRZL(data)
    n = length(data);
    x = [];
    y = [];
    
    for i = 1:n
        x = [x i-1 i];
        
        if data(i) == 1
            y = [y -1 -1];  % Negative amplitude for '1'
        else
            y = [y 1 1]; % Positive amplitude for '0'
        end
    end
end



function [x, y] = NRZI(data)
    n = length(data);
    x = [];
    y = [];
    current_state = 1;  % Let's assume the initial state is '1' (high)
    
    for i = 1:n
        x = [x i-1 i];
        
        if data(i) == 1
            % If bit is '1', invert the current state
            current_state = -current_state;
        end
        y = [y current_state current_state];
    end
end



function [x, y] = Polar_RZ(data)
    n = length(data);
    x = [];
    y = [];
    
    for i = 1:n
        x = [x (i-1) (i-0.5) (i-0.5) i];
        
        if data(i) == 1
            y = [y 1 1 0 0];
        else
            y = [y -1 -1 0 0];
        end
    end
end






function [x, y] = Manchester(data)
    n = length(data);
    x = [];
    y = [];
    for i = 1:n
        x = [x i-1 i-1+0.5 i-1+0.5 i];
        if data(i) == 0
            y = [y 1 1 -1 -1];
        else
            y = [y -1 -1 1 1];
        end
    end
end



function [x, y] = DifferentialManchester(Data)
    % Initialize time and signal vectors
    T = length(Data); % Length of the data
    x = 0:0.01:T; % Time vector
    y = zeros(1, length(x)); % Signal vector
    curr_level = -1; % Initialize current level as low voltage

    for i = 1:T
        % Find the indices for the current bit duration
        indices = find(x >= (i-1) & x < i);

        % Make transition in the middle of the bit duration
        middle = find(x >= (i-0.5) & x < i);
        
        % Get the last index for the current bit duration
        last_index = min(length(indices), length(middle));

        if Data(i) == 1
            % For '1', no transition at the start
            y(indices(1:last_index)) = -curr_level;

            % Then transition in the middle
            curr_level = -curr_level;
            y(indices(last_index+1:end)) = -curr_level;
        else
            % For '0', transition at the start
            curr_level = -curr_level;
            y(indices(1:last_index)) = -curr_level;
            
            % Then transition in the middle
            curr_level = -curr_level;
            y(indices(last_index+1:end)) = -curr_level;
        end
    end
end



    function [x, y] = AMI(data)
    n = length(data);
    x = [];
    y = [];
    currentLevel = 1;

    for i = 1:n
        if data(i) == 1
            x = [x, (i-1), i];
            y = [y, currentLevel, currentLevel];
            currentLevel = -currentLevel; 
        else
            x = [x, (i-1), i];
            y = [y, 0, 0];
        end
    end
    end

    function [x, y] = Pseudoternary(data)
    n = length(data);
    x = [];
    y = [];
    currentLevel = 1;

    for i = 1:n
        if data(i) == 0
            x = [x, (i-1), i];
            y = [y, currentLevel, currentLevel];
            currentLevel = -currentLevel; 
        else
            x = [x, (i-1), i];
            y = [y, 0, 0];
        end
    end
end



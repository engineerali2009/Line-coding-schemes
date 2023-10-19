% Dr Ali Mohamed AbdelAziz
% 18 Oct 2023
% Matlab file

% change your input Data
data = [1 1 0 1 1 0 0 0 0 0 0 0 0 1];

% Generate Manchester Encoding
[x_manchester, y_manchester] = Manchester(data);

% Generate Differential Manchester Encoding
[x_diff_manchester, y_diff_manchester] = DifferentialManchester(data);

% Generate Square wave for the input data
[x_square, y_square] = GenerateSquareWave(data);


% Generate Unipolar NRZ Encoding
[x_unipolar_nrz, y_unipolar_nrz] = Unipolar_NRZ(data);


% Generate NRZI Encoding
[x_nrzi, y_nrzi] = NRZI(data);

% Generate Unipolar RZ Encoding
[x_unirz, y_unirz] = Unipolar_RZ(data);

% Generate Bipolar RZ Encoding
[x_birz, y_birz] = Bipolar_RZ(data);


% Generate AMI_RZ Encoding
[x_AmiRZ, y_AmiRZ] = AMI_RZ(data);

% Generate AMI_NRZ Encoding
   [x_AmiNRZ, y_AmiNRZ] = AMI_NRZ(data);



% Plot
figure('Position', [100, 100, 800, 1200]); % x, y, width, height

% Plotting original data as a square wave
subplot(9,1,1);
plot(x_square, y_square, 'LineWidth', 2);
title('Original Data Square Wave');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -0.5, 1.5]);
xticks(0:1:length(data)-1);

% Plotting Manchester Encoding
subplot(9,1,2);
plot(x_manchester, y_manchester, 'LineWidth', 2);
title('Manchester Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);

% Plotting Differential Manchester Encoding
subplot(9,1,3);
plot(x_diff_manchester, y_diff_manchester, 'LineWidth', 2);
title('Differential Manchester Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);


% Plotting Unipolar NRZ  Encoding
subplot(9,1,4);
plot(x_unipolar_nrz, y_unipolar_nrz, 'LineWidth', 2);
title('Unipolar NRZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);




% Plotting  NRZI  Encoding
subplot(9,1,5);
plot(x_nrzi, y_nrzi, 'LineWidth', 2);
title('NRZI Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -2, 2]);
xticks(0:1:length(data)-1);


% Plotting  Unipolar RZ  Encoding
subplot(9,1,6);
stairs(x_unirz, y_unirz, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('Unipolar RZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -0.5, 1.5]);
xticks(0:1:length(data)-1);


% Plotting  Bipolar RZ  Encoding
subplot(9,1,7);
stairs(x_birz, y_birz, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('Bipolar RZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);




% Plotting  AMI RZ  Encoding
subplot(9,1,8);
stairs(x_AmiRZ, y_AmiRZ, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('AMI RZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);



% Plotting  AMI NRZ  Encoding
subplot(9,1,9);
stairs(x_AmiNRZ, y_AmiNRZ, 'LineWidth', 2); % Use stairs function instead of plot for stepwise changes
title('AMI NRZ Encoding');
xlabel('Time');
ylabel('Amplitude');
grid on;
axis([0, length(data), -1.5, 1.5]);
xticks(0:1:length(data)-1);





% Save plot in EPS format
saveas(gcf, 'test.eps', 'epsc')



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

function [x, y] = DifferentialManchester(data)
    n = length(data);
    x = [];
    y = [];
    last_transition = 1; % Start with a positive transition
    for i = 1:n
        x = [x i-1 i-1+0.5 i-1+0.5 i];
        if data(i) == 0
            y = [y last_transition last_transition -last_transition -last_transition];
        else
            y = [y -last_transition -last_transition last_transition last_transition];
            last_transition = -last_transition; % Invert the transition for 1
        end
    end
end


function [x, y] = Unipolar_NRZ(data)
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

function [x, y] = NRZI(data)
    n = length(data);
    x = [];
    y = [];
    current_state = -1;  % Let's assume the initial state is '-1' (low)
    
    for i = 1:n
        x = [x i-1 i];
        
        if data(i) == 1
            % If bit is '1', invert the current state
            current_state = -current_state;
        end
        y = [y current_state current_state];
    end
end

function [x, y] = Unipolar_RZ(data)
    n = length(data);
    x = [];
    y = [];
    for i = 1:n
        x = [x (i-1) (i-1+0.25) (i-1+0.25) (i-1+0.75) (i-1+0.75) i];
        if data(i) == 1
            y = [y 0 0 1 1 0 0];
        else
            y = [y 0 0 0 0 0 0];
        end
    end
end

    function [x, y] = Bipolar_RZ(data)
    n = length(data);
    x = [0];
    y = [0];
    
    for i = 1:n
        x = [x (i-1+0.25) (i-1+0.75) (i-1+0.75) i];
        if data(i) == 1
            y = [y 1 1 0 0];
        else
            y = [y -1 -1 0 0];
        end
    end
    end





    function [x, y] = AMI_RZ(data)
    n = length(data);
    x = [];
    y = [];
    currentLevel = 1;

    for i = 1:n
        if data(i) == 1
            x = [x, (i-1), (i-1)+0.5, (i-1)+0.75, (i-1)+0.75, i];
            y = [y, 0, currentLevel, currentLevel, 0, 0];
            currentLevel = -currentLevel; 
        else
            x = [x, (i-1), (i-1)+0.5, i];
            y = [y, 0, 0, 0];
        end
    end
    end

    function [x, y] = AMI_NRZ(data)
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


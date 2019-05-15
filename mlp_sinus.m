clear all
close all

% The number of examples taken from the function
n_examples = 20; 

examples = (0:2*pi/(n_examples-1):2*pi)';
goal = sin(examples);

% Boolean for plotting animation
plot_animation = true;
plot_bigger_picture = false;

% Parameters for the network
learn_rate = 0.1;                % learning rate
max_epoch = 5000;              % maximum number of epochs


mean_weight = 0;
weight_spread = 1;

n_input = size(examples,2);
n_hidden = 50;
n_output = size(goal,2);

% Noise level at input
noise_level = 0.01;

bias_value = -1;

% Initializing the weights
w_hidden = rand(n_input + 1, n_hidden) .* weight_spread - weight_spread/2 + mean_weight;
w_output = rand(n_hidden, n_output) .* weight_spread - weight_spread/2 + mean_weight;

% Start training
stop_criterium = 0;
epoch = 0;

while ~stop_criterium
    epoch = epoch + 1;
    
    % Add noise to the input
    noise = randn(size(examples)) .* noise_level;
    input_data = examples + noise;
    
    % Append bias
    input_data(:,n_input+1) = ones(size(examples,1),1) .* bias_value;
    
    epoch_error = 0;
    epoch_delta_hidden = 0;
    epoch_delta_output = 0;
    for pattern = 1:size(input_data,1)
       % Copy the for-loop body from mlp_2011.m
    end
    
    h_error(epoch) = epoch_error / size(input_data,1);
    log_delta_output(epoch) = epoch_delta_output;
    log_delta_hidden(epoch) = epoch_delta_hidden;

    if epoch > max_epoch
        stop_criterium = 1;
    end
    
    % Add your stop criterion here
    
    % Plot the animation
    if and((mod(epoch,20)==0),(plot_animation))
        %out = zeros(21,1);
        nPoints = 100;
        input = linspace(0, 2 * pi, nPoints);
        for x=1:nPoints
            h_out = sigmoid([input(x) bias_value] * w_hidden);
            out(x) = output_function(h_out * w_output); 
        end
        figure(1)
        plot(input,out,'r-','DisplayName','Output network')
        hold on
        plot(input,sin(input),'b-','DisplayName','Goal (sin[x])')
        hold on
        scatter(examples, goal, 'DisplayName', 'Examples')
        hold on
        title(['Output and goal. Epoch: ' num2str(epoch)]);
        xlim([0 2*pi])
        ylim([-1.1 1.1])
        set(gca,'XTick',0:pi/2:2*pi)
        set(gca,'XTickLabel',{'0','1/2 pi','pi','3/2 pi ','2 pi'})
        xlabel('Input')
        ylabel('Output')
        legend('location','NorthEast')
        hold off
        pause(0.01)
    end

end


% Plot error
figure(2)
plot(1:epoch,h_error)
title('Mean squared error vs epoch');
xlabel('Epoch nr.');
ylabel('MSE');

%Plot the bigger picture
if plot_bigger_picture
    figure(3)
    in_raw = (-5:0.1:15)';
    in_raw = horzcat(in_raw,(bias_value*ones(size(in_raw))));
    h_big = sigmoid(in_raw * w_hidden);
    o_big = output_function(h_big * w_output);
    
    plot(-5:0.1:15,o_big,'r-','DisplayName','Output network')
    hold on
    plot(-5:0.1:15,sin(-5:0.1:15),'b-','DisplayName','Goal (sin[x])')
    hold on
    scatter(examples, sin(examples), 'DisplayName', 'Examples');
    hold off
    xlabel('Input')
    ylabel('Output')
    legend('location','NorthEast')
    title('The bigger picture')
end


function [output] = d_output_function(x)
    temp = sigmoid(x);
    output = temp .* (1 - temp);
end
% Joseph Fiume
% EE348
% lab 6
% 11/6/2020

close all; clear; clc; clf;

% h[n] impulse response
h_n = [0 -1 -2 -3];
h = [1/4 1/4 1/4 1/4];

% x[n] discrete-time input
% x_n = [0 -1];
% x = [1 3];
x_n = [2 1 0 -1 -2];
x = [1 2 1 -1 1];

% filter order
M = 2;
size_Y = (numel(h) + numel(x)) - 1;

% plots of h[n] and x[n]
stem(h);
stem(x);
axis([-4 10 -1 2]);
xlabel('n');
ylabel('X[n]');

% indices of h and n
h_i = 1;
x_i = 1;
h_j = 1;
x_j = 1;
Y = [];

for k = 0:M
    x_minus_k = (x_n - k);
    % x cannot have negative indices
    if x_minus_k(1) >= 0
        % loop until Y has all its convolution elements
        while numel(Y) < size_Y - 1
            % loop until all the elements in both x and h have been
            % summed
            while x_i ~= numel(x) && h_i ~= numel(h)
                % multiply the matrices, take the sum of all elements
                % in the correct range
                yi = h(: , h_i:h_j) .* x(:, x_i:x_j);
                sum = cumsum(yi);
                Y = [Y, sum(:,numel(sum))];
                % if x is larger than h, we have to alter its
                % indices to keep the size of the matrix multiplied the
                % same as h and if h is larger than x, we have to alter its
                % indices to keep the size of the matrix multiplied the
                % same as x
                if x_j < numel(x) && h_j < numel(h)
                    x_j = x_j + 1;
                    h_j = h_j + 1;
                % the case where h[n] is larger than x[n]
                elseif h_j < numel(h)
                    h_j = h_j + 1;
                    h_i = h_i + 1;
                % the case where x[n] is larger than h[n]
                elseif x_j < numel(x)
                    x_j = x_j + 1;
                    x_i = x_i + 1;
                elseif x_i < numel(x) && h_i < numel(h)
                    x_i = x_i + 1;
                    h_i = h_i + 1;
                end
            end
        end
    end
end

% the loop does not add the final element to the array, so we add it
% manually at the end
Y = [Y, h(: , numel(h)) .* x(:, numel(x))];
% discrete-time output
Y
convolution_function = conv(x,h)
Y == conv(x,h)
stem(Y);
axis([-4 10 0 1]);
xlabel('n');
ylabel('Y[n]');

% part 3
% Commutativity of Convolution
y = conv(h,x)
w = conv(x,h)
y == w
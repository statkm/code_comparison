% Mandelbrot Set Calculation in Octave/MATLAB
% Computes the Mandelbrot set and measures execution time
%
% Run: octave mandelbrot.m

function result = mandelbrot(width, height, max_iter, xlim, ylim)
    if nargin < 1, width = 800; end
    if nargin < 2, height = 600; end
    if nargin < 3, max_iter = 100; end
    if nargin < 4, xlim = [-2.0, 1.0]; end
    if nargin < 5, ylim = [-1.0, 1.0]; end
    
    result = zeros(height, width);
    
    for py = 1:height
        y0 = ylim(1) + (py - 1) * (ylim(2) - ylim(1)) / (height - 1);
        for px = 1:width
            x0 = xlim(1) + (px - 1) * (xlim(2) - xlim(1)) / (width - 1);
            
            % Mandelbrot iteration
            x = 0.0;
            y = 0.0;
            iteration = 0;
            
            while (x*x + y*y <= 4.0 && iteration < max_iter)
                xtemp = x*x - y*y + x0;
                y = 2.0*x*y + y0;
                x = xtemp;
                iteration = iteration + 1;
            end
            
            result(py, px) = iteration;
        end
    end
end

% Main execution
tic;
result = mandelbrot();
result_sum = sum(result(:));
elapsed = toc;

fprintf('Result sum: %d\n', result_sum);
fprintf('Time: %f seconds\n', elapsed);

% Save result to CSV
fid = fopen('mandelbrot_octave_data.csv', 'w');
fprintf(fid, 'x,y,iter\n');

[height, width] = size(result);
for py = 1:height
    for px = 1:width
        fprintf(fid, '%d,%d,%d\n', px-1, py-1, result(py, px));
    end
end

fclose(fid);
fprintf('Result saved to mandelbrot_octave_data.csv\n');

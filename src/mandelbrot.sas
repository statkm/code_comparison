/* SPDX-License-Identifier: MIT */
/* Copyright (c) 2025 Mandelbrot Benchmark Project Contributors */
/*
 * Mandelbrot Set Calculation in SAS - Macro Function Library
 * Provides reusable macros for Mandelbrot set computation
 */

%let width = 800;
%let height = 600;
%let max_iter = 100;

/* Macro to calculate Mandelbrot set and return dataset */
%macro calc_mandelbrot(width=800, height=600, max_iter=100, outds=mandelbrot_result);
    data &outds;
        length px py iteration 8;
        start_time = datetime();
        total = 0;
        
        do py = 0 to &height - 1;
            do px = 0 to &width - 1;
                /* Map pixel to complex plane */
                x0 = -2.0 + 3.0 * px / (&width - 1);
                y0 = -1.0 + 2.0 * py / (&height - 1);
                
                /* Mandelbrot iteration */
                x = 0;
                y = 0;
                iteration = 0;
                
                do while (x*x + y*y <= 4 and iteration < &max_iter);
                    xtemp = x*x - y*y + x0;
                    y = 2*x*y + y0;
                    x = xtemp;
                    iteration + 1;
                end;
                
                total + iteration;
                output;  /* Output each pixel's result */
            end;
        end;
        
        end_time = datetime();
        elapsed = end_time - start_time;
        
        put 'Elapsed time: ' elapsed 8.6 'seconds';
        put 'Total: ' total;
        
        /* Keep only the necessary variables in output */
        keep px py iteration;
    run;
%mend calc_mandelbrot;

/* For standalone execution: calculate with default parameters */
%if %sysfunc(getoption(sysin)) ne %then %do;
    %calc_mandelbrot(width=&width, height=&height, max_iter=&max_iter);
%end;

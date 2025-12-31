#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

"""
Mandelbrot Set Calculation in Python (Pure Python version)
Computes the Mandelbrot set and measures execution time
"""

import time

def mandel_py_pure(width=800, height=600, max_iter=100, 
                   xlim=(-2.0, 1.0), ylim=(-1.0, 1.0)):
    """
    Calculate Mandelbrot set (Pure Python version)
    
    Args:
        width: Image width
        height: Image height
        max_iter: Maximum iterations
        xlim: X-axis range (real part)
        ylim: Y-axis range (imaginary part)
    
    Returns:
        2D list of iteration counts
    """
    result = [[0 for _ in range(width)] for _ in range(height)]
    
    for py in range(height):
        for px in range(width):
            # Map pixel to complex plane
            x0 = px * (xlim[1] - xlim[0]) / width + xlim[0]
            y0 = py * (ylim[1] - ylim[0]) / height + ylim[0]
            
            # Mandelbrot iteration
            x = 0.0
            y = 0.0
            iteration = 0
            
            while x*x + y*y <= 4.0 and iteration < max_iter:
                xtemp = x*x - y*y + x0
                y = 2.0*x*y + y0
                x = xtemp
                iteration += 1
            
            result[py][px] = iteration
    
    return result

if __name__ == '__main__':
    start = time.time()
    result = mandel_py_pure()
    elapsed = time.time() - start
    
    print(f"{elapsed:.6f}")

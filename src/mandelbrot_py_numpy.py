#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

"""
Mandelbrot Set Calculation in Python (NumPy vectorized version)
Computes the Mandelbrot set and measures execution time
"""

import time
import numpy as np

def mandel_py_numpy(width=800, height=600, max_iter=100, 
                    xlim=(-2.0, 1.0), ylim=(-1.0, 1.0)):
    """
    Calculate Mandelbrot set (NumPy vectorized version)
    
    Args:
        width: Image width
        height: Image height
        max_iter: Maximum iterations
        xlim: X-axis range (real part)
        ylim: Y-axis range (imaginary part)
    
    Returns:
        2D array of iteration counts
    """
    # Create coordinate arrays
    x = np.linspace(xlim[0], xlim[1], width)
    y = np.linspace(ylim[0], ylim[1], height)
    X, Y = np.meshgrid(x, y)
    
    # Initialize complex plane
    C = X + 1j * Y
    Z = np.zeros_like(C)
    M = np.zeros(C.shape, dtype=int)
    
    # Vectorized iteration
    for i in range(max_iter):
        # Points that haven't diverged yet
        mask = np.abs(Z) <= 2
        # Update Z for non-diverged points
        Z[mask] = Z[mask]**2 + C[mask]
        # Increment iteration count
        M[mask] = i + 1
    
    return M

if __name__ == '__main__':
    start = time.time()
    result = mandel_py_numpy()
    elapsed = time.time() - start
    
    print(f"{elapsed:.6f}")

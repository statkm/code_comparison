// Mandelbrot Set Calculation in Rust (Parallel Version)
// Computes the Mandelbrot set using Rayon for parallelization
//
// Build: cargo build --release --bin mandelbrot_parallel
// Run: .\target\release\mandelbrot_parallel.exe

use rayon::prelude::*;
use std::time::Instant;

fn mandel_rust_parallel(width: usize, height: usize, max_iter: usize, 
                        xlim: (f64, f64), ylim: (f64, f64)) -> Vec<Vec<usize>> {
    let mut result = vec![vec![0; width]; height];
    
    // Process rows in parallel
    result.par_iter_mut().enumerate().for_each(|(py, row)| {
        for px in 0..width {
            // Map pixel to complex plane
            let x0 = px as f64 * (xlim.1 - xlim.0) / width as f64 + xlim.0;
            let y0 = py as f64 * (ylim.1 - ylim.0) / height as f64 + ylim.0;
            
            // Mandelbrot iteration
            let mut x = 0.0;
            let mut y = 0.0;
            let mut iteration = 0;
            
            while x * x + y * y <= 4.0 && iteration < max_iter {
                let xtemp = x * x - y * y + x0;
                y = 2.0 * x * y + y0;
                x = xtemp;
                iteration += 1;
            }
            
            row[px] = iteration;
        }
    });
    
    result
}

fn main() {
    let width = 1500;
    let height = 1000;
    let max_iter = 1000;
    let xlim = (-2.0, 1.0);
    let ylim = (-1.0, 1.0);
    
    let start = Instant::now();
    let _result = mandel_rust_parallel(width, height, max_iter, xlim, ylim);
    let elapsed = start.elapsed();
    
    println!("Time: {:.6} seconds", elapsed.as_secs_f64());
}

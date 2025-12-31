// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Mandelbrot Benchmark Project Contributors
//
// Mandelbrot Set Calculation in Rust
// Computes the Mandelbrot set and measures execution time
//
// Compile: rustc -C opt-level=3 mandelbrot.rs -o mandelbrot_rust.exe
// Run: .\mandelbrot_rust.exe

use std::time::Instant;
use std::fs::File;
use std::io::Write;

fn mandel_rust(width: usize, height: usize, max_iter: usize, 
               xlim: (f64, f64), ylim: (f64, f64)) -> Vec<Vec<usize>> {
    let mut result = vec![vec![0; width]; height];
    
    for py in 0..height {
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
            
            result[py][px] = iteration;
        }
    }
    
    result
}

fn main() {
    let width = 800;
    let height = 600;
    let max_iter = 100;
    let xlim = (-2.0, 1.0);
    let ylim = (-1.0, 1.0);
    
    let start = Instant::now();
    let result = mandel_rust(width, height, max_iter, xlim, ylim);
    let elapsed = start.elapsed();
    
    println!("Time: {:.6} seconds", elapsed.as_secs_f64());
    
    // Save result to CSV
    let mut file = File::create("mandelbrot_rust_data.csv").expect("Unable to create file");
    writeln!(file, "x,y,iter").expect("Unable to write header");
    
    for (py, row) in result.iter().enumerate() {
        for (px, &iter) in row.iter().enumerate() {
            writeln!(file, "{},{},{}", px, py, iter).expect("Unable to write data");
        }
    }
    
    println!("Result saved to mandelbrot_rust_data.csv");
}

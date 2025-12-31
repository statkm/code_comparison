// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

#include <iostream>
#include <fstream>
#include <chrono>
#include <vector>
#include <cstring>

std::vector<std::vector<int>> mandel_cpp(int W = 800, int H = 600, int maxiter = 100,
                                          double xr0 = -2.0, double xr1 = 1.0,
                                          double yr0 = -1.0, double yr1 = 1.0) {
    std::vector<std::vector<int>> result(H, std::vector<int>(W));
    
    for (int j = 0; j < H; j++) {
        double ci = yr0 + (yr1 - yr0) * j / (H - 1.0);
        for (int i = 0; i < W; i++) {
            double cr = xr0 + (xr1 - xr0) * i / (W - 1.0);
            double zr = 0.0, zi = 0.0;
            int k = 0;
            while (zr * zr + zi * zi <= 4.0 && k < maxiter) {
                double tr = zr * zr - zi * zi + cr;
                zi = 2 * zr * zi + ci;
                zr = tr;
                k++;
            }
            result[j][i] = k;
        }
    }
    return result;
}

int main(int argc, char* argv[]) {
    bool save_csv = false;
    
    // Check for --save-csv argument
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--save-csv") == 0) {
            save_csv = true;
            break;
        }
    }
    
    auto start = std::chrono::high_resolution_clock::now();
    auto result = mandel_cpp();
    auto end = std::chrono::high_resolution_clock::now();
    
    std::chrono::duration<double> elapsed = end - start;
    long long sum = 0;
    for (const auto& row : result) {
        for (int val : row) {
            sum += val;
        }
    }
    
    std::cout << "Result: " << sum << std::endl;
    std::cout << "Time: " << elapsed.count() << " seconds" << std::endl;
    
    if (save_csv) {
        std::cout << "Saving to mandelbrot_cpp_data.csv..." << std::endl;
        std::ofstream outfile("mandelbrot_cpp_data.csv");
        
        for (size_t j = 0; j < result.size(); j++) {
            for (size_t i = 0; i < result[j].size(); i++) {
                outfile << result[j][i];
                if (i < result[j].size() - 1) {
                    outfile << ",";
                }
            }
            outfile << "\n";
        }
        
        outfile.close();
        std::cout << "Data saved successfully!" << std::endl;
    }
    
    return 0;
}

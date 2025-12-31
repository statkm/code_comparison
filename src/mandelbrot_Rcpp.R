# install.packages("Rcpp")
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

library(Rcpp)
cppFunction('
IntegerMatrix mandel_cpp(int W=800, int H=600, int maxiter=100, 
                         double xr0=-2.0, double xr1=1.0, 
                         double yr0=-1.0, double yr1=1.0){
  IntegerMatrix result(H, W);
  for(int j=0;j<H;++j){
    double ci = yr0 + (yr1-yr0)*j/(H-1.0);
    for(int i=0;i<W;++i){
      double cr = xr0 + (xr1-xr0)*i/(W-1.0);
      double zr=0, zi=0; int k=0;
      while(zr*zr+zi*zi<=4.0 && k<maxiter){
        double tr = zr*zr - zi*zi + cr;
        zi = 2*zr*zi + ci;
        zr = tr;
        ++k;
      }
      result(j, i) = k;
    }
  }
  return result;
}')
print(system.time(mandel_cpp()))

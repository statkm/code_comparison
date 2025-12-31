# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

mandel_R <- function(W=800, H=600, maxiter=100, xlim=c(-2.0, 1.0), ylim=c(-1.0, 1.0)) {
  xr <- seq(xlim[1], xlim[2], length.out=W); yr <- seq(ylim[1], ylim[2], length.out=H)
  result <- matrix(0, nrow=H, ncol=W)
  for (j in 1:H) {
    for (i in 1:W) {
      cr <- xr[i]; ci <- yr[j]; zr <- 0.0; zi <- 0.0; k <- 0L
      while (zr*zr + zi*zi <= 4.0 && k < maxiter) {
        tr <- zr*zr - zi*zi + cr
        zi <- 2*zr*zi + ci
        zr <- tr
        k <- k + 1L
      }
      result[j, i] <- k
    }
  }
  result
}

print(system.time(mandel_R()))
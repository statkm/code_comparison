# SPDX-License-Identifier: MIT
# Copyright (c) 2025 Mandelbrot Benchmark Project Contributors

function mandel_jl(W=800, H=600, maxiter=100,
                   xlim=(-2.0, 1.0), ylim=(-1.0, 1.0))
    result = zeros(Int, H, W)
    
    for j in 1:H
        ci = ylim[1] + (ylim[2] - ylim[1]) * (j-1) / (H-1)
        for i in 1:W
            cr = xlim[1] + (xlim[2] - xlim[1]) * (i-1) / (W-1)
            zr = 0.0; zi = 0.0; k = 0
            while zr*zr + zi*zi <= 4.0 && k < maxiter
                tr = zr*zr - zi*zi + cr
                zi = 2*zr*zi + ci
                zr = tr
                k += 1
            end
            result[j, i] = k
        end
    end
    result
end
@time mandel_jl()

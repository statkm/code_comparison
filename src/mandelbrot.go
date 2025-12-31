// SPDX-License-Identifier: MIT
// Copyright (c) 2025 Mandelbrot Benchmark Project Contributors
//
// Mandelbrot Set Calculation in Go
// Computes the Mandelbrot set and measures execution time
//
// Build: go build -o mandelbrot_go.exe mandelbrot.go
// Run: .\mandelbrot_go.exe

package main

import (
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
	"time"
)

func mandelGo(width, height, maxIter int, xlim, ylim [2]float64) [][]int {
	result := make([][]int, height)
	for i := range result {
		result[i] = make([]int, width)
	}

	for py := 0; py < height; py++ {
		for px := 0; px < width; px++ {
			// Map pixel to complex plane
			x0 := float64(px)*(xlim[1]-xlim[0])/float64(width) + xlim[0]
			y0 := float64(py)*(ylim[1]-ylim[0])/float64(height) + ylim[0]

			// Mandelbrot iteration
			var x, y float64
			iteration := 0

			for x*x+y*y <= 4.0 && iteration < maxIter {
				xtemp := x*x - y*y + x0
				y = 2.0*x*y + y0
				x = xtemp
				iteration++
			}

			result[py][px] = iteration
		}
	}

	return result
}

func main() {
	width := 800
	height := 600
	maxIter := 100
	xlim := [2]float64{-2.0, 1.0}
	ylim := [2]float64{-1.0, 1.0}

	start := time.Now()
	result := mandelGo(width, height, maxIter, xlim, ylim)
	elapsed := time.Since(start)

	fmt.Printf("Time: %f seconds\n", elapsed.Seconds())

	// Save result to CSV
	file, err := os.Create("mandelbrot_go_data.csv")
	if err != nil {
		fmt.Printf("Error creating file: %v\n", err)
		return
	}
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	// Write header
	writer.Write([]string{"x", "y", "iter"})

	// Write data
	for py := 0; py < height; py++ {
		for px := 0; px < width; px++ {
			writer.Write([]string{
				strconv.Itoa(px),
				strconv.Itoa(py),
				strconv.Itoa(result[py][px]),
			})
		}
	}

	fmt.Println("Result saved to mandelbrot_go_data.csv")
}

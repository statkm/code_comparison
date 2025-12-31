! SPDX-License-Identifier: MIT
! Copyright (c) 2025 Mandelbrot Benchmark Project Contributors
!
! Mandelbrot Set Calculation in Fortran
! Computes the Mandelbrot set and measures execution time
!
! Compile: gfortran -O3 mandelbrot.f90 -o mandelbrot_fortran.exe
! Run: .\mandelbrot_fortran.exe

program mandelbrot
    implicit none
    integer, parameter :: width = 800
    integer, parameter :: height = 600
    integer, parameter :: max_iter = 100
    real(8), parameter :: xlim(2) = (/-2.0d0, 1.0d0/)
    real(8), parameter :: ylim(2) = (/-1.0d0, 1.0d0/)
    
    integer :: result(height, width)
    integer :: px, py, iteration, csv_unit, i, j
    real(8) :: x0, y0, x, y, xtemp
    integer :: start_count, end_count, count_rate
    real(8) :: elapsed_time
    
    ! Start timing
    call system_clock(start_count, count_rate)
    
    ! Calculate Mandelbrot set
    do py = 1, height
        y0 = ylim(1) + (py - 1) * (ylim(2) - ylim(1)) / (height - 1)
        do px = 1, width
            x0 = xlim(1) + (px - 1) * (xlim(2) - xlim(1)) / (width - 1)
            
            ! Mandelbrot iteration
            x = 0.0d0
            y = 0.0d0
            iteration = 0
            
            do while (x*x + y*y <= 4.0d0 .and. iteration < max_iter)
                xtemp = x*x - y*y + x0
                y = 2.0d0*x*y + y0
                x = xtemp
                iteration = iteration + 1
            end do
            
            result(py, px) = iteration
        end do
    end do
    
    ! End timing
    call system_clock(end_count)
    elapsed_time = real(end_count - start_count, 8) / real(count_rate, 8)
    
    ! Print result (to prevent optimization from removing the calculation)
    write(*,'(A,I0)') 'Result sum: ', sum(result)
    write(*,'(A,F10.6,A)') 'Time: ', elapsed_time, ' seconds'
    
    ! Save result to CSV
    open(newunit=csv_unit, file='mandelbrot_fortran_data.csv', status='replace')
    write(csv_unit, '(A)') 'x,y,iter'
    
    do j = 1, height
        do i = 1, width
            write(csv_unit, '(I0,A,I0,A,I0)') i-1, ',', j-1, ',', result(j, i)
        end do
    end do
    
    close(csv_unit)
    write(*,'(A)') 'Result saved to mandelbrot_fortran_data.csv'
    
end program mandelbrot

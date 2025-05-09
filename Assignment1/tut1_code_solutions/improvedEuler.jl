using Plots
println("\033c")
topRange = 4
dt = [round(10.0^(-n), sigdigits=3) for n in 0:topRange]
x0 = 1.0
f = (x::Float64) -> -x;
correctAns = exp(-1)
function solveEulerImproved(dt::Vector{Float64}, xDot, xInitial, timeInitial, timeFinal)
    solutions::Vector{Float64} = Vector{Float64}()
    for dt_i in dt
        t = timeInitial
        x = xInitial
        while t<timeFinal
            t += dt_i             
            k1 = xDot(x)           
            k2 = xDot(x + k1 * dt_i) 
            x += ((k1 + k2) / 2.0) * dt_i 
        end
        push!(solutions, x)
    end
    return solutions
    
end

sols = solveEulerImproved(dt, f, 1.0, 0.0, 1.0)
absError = ((sols.-correctAns).^2).^(0.5)
lnAbsError = log.(absError)
for i in 1:topRange+1
    println("For time: ", round(dt[i], sigdigits=3), "   x(1): ", sols[i])
end
println("Actual answer is: ", correctAns)




plot( title="Improved Euler",
    plot(log.(dt),lnAbsError, marker=:circle, label=["ln(Error) vs ln(dt)"], xlabel="ln(dt)", ylabel="ln(abs(Error))", size=(900, 800)),
    plot(dt, absError, marker=:circle, label=["Error vs dt"], xlabel="dt", ylabel="abs(Error)", size=(900, 800)),
    layout = (2, 1),
    size = (900, 800)
)
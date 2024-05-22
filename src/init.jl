using Timers; tic()
using ControlPlots, LinearAlgebra, ModelingToolkit, Revise
# Re = 3.8e4
# xz coordination system, x downwind, z upwards

const RHO = 1.225  # air density at zero height and 15 °C    [kg/m³]
const AREA = 0.8   # area of the cylinder in m²
const R = 0.2      # radius in m
const M = 0.25     # mass of the cylinder incl. motor in kg

# x: speed ratio
# x = ωR/v_a
function cd(x)
    -0.0211*x^3 + 0.1837*x^2 +0.1183*x+0.5
end

# x: speed ratio
function cl(x)
    0.0126 * x^4 - 0.2004*x^3 + 0.7482*x^2 + 1.3447*x
end

# x: speed ratio
# calculate the tether force and evelation angle in quasi-steady state
function calc_steady_force(x, v_wind::Real)
    v_a = v_wind
    CL = cl(x) 
    CD = cd(x)
    L = 0.5 * RHO * v_a^2 * AREA * CL
    D = 0.5 * RHO * v_a^2 * AREA * CD     # calculate sum of f_a and f_t
    norm([D, L]), rad2deg(atan(L, D))
end

# calculate the force and acceleration vectors for dynamic simulation
# elev: elevation angle [rad]
# returns: f_t, acc with f_t: tether force vector and acc: acceleration vector
function calc_force_acc(elev, x, v_wind)
    v_a = v_wind
    CL = cl(x) 
    CD = cd(x)
    L = 0.5 * RHO * v_a^2 * AREA * CL
    D = 0.5 * RHO * v_a^2 * AREA * CD
    f_a = [D, L] # aerodynamic force
    pos = [cos(elev), sin(elev)]
    # calculate force vector in the direction of the tether
    u = f_a
    v = pos
    f_pos = (u ⋅ v) / (norm(v))^2 * v 
    f_t = - f_pos
    # calculate sum of f_a and f_t
    f_acc = f_a + f_t
    return f_acc/M
end

@register_array_symbolic calc_force_acc(elev, x, v_wind) begin
    size=(2,)
    eltype=eltype(elev)
end

includet("main.jl")
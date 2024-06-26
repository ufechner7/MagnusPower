using ControlPlots, LinearAlgebra
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
function calc_force_acc(elev, x, v_wind::Real)
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
    return f_t, f_acc/M
end

function test()
    x = 2
    v_wind = 10
    f, elev=calc_steady_force(x, v_wind)
    # (219.24586151423705, 73.07483049579157)
    calc_force_acc(deg2rad(elev-5), x, v_wind)
end

X = 0.0:0.1:5.5
CL = cl.(X)
CD = cd.(X)
LoD = CL ./ CD

plot(X, LoD, xlabel="Speed ratio", ylabel="Lift over Drag")
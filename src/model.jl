using ModelingToolkit, OrdinaryDiffEq

mutable struct Model
    sys
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
    f_pos = (f_a ⋅ pos) / (norm(pos))^2 * pos 
    f_t = - f_pos
    # calculate sum of f_a and f_t
    f_acc = f_a + f_t
    return f_t, f_acc/M
end

const elev0 = 70.0 # initial elevation angle in degrees
const L0    = 10.0 # initial tether length
const POS0  =   L0*[cos(deg2rad(elev0)), sin(deg2rad(elev0))]
const VEL0  = zeros(2)
const ACC0  = zeros(2)
function model2D()
    @variables t
    @variables pos(t)[1:2]  = POS0
    @variables vel(t)[1:2]  = VEL0
    @variables acc(t)[1:2]  = ACC0
    D   = Differential(t)
    eqs = [
        D(pos) ~ vel,
        D(vel) ~ acc
    ]
    @named sys = ODESystem(eqs, t)
    Model(sys)
end
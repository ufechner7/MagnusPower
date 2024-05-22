using ModelingToolkit, OrdinaryDiffEq

mutable struct Model
    sys
end

const elev0 = 70.0 # initial elevation angle in degrees
const L0    = 10.0 # initial tether length
const POS0  =   L0*[cos(deg2rad(elev0)), sin(deg2rad(elev0))]
const VEL0  = zeros(2)
const ACC0  = zeros(2)
const F_T0  = zeros(2)
function model2D()
    @variables t
    @variables pos(t)[1:2]  = POS0
    @variables vel(t)[1:2]  = VEL0
    @variables acc(t)[1:2]  = ACC0
    @variables f_t(t)[1:2]  = F_T0
    @variables elev(t) = deg2rad(elev0)
    @parameters v_wind = 10.0
    @parameters x = 2.0 
    D   = Differential(t)
    eqs = [
        D(pos) ~ vel,
        D(vel) ~ acc,
        elev   ~ atan(pos[1]/pos[2]),
        acc    ~ calc_force_acc(elev, x, v_wind)
    ]
    @named sys = ODESystem(eqs, t)
    Model(sys)
end
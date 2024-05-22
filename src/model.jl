using ModelingToolkit, OrdinaryDiffEq

mutable struct Model
    sys
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
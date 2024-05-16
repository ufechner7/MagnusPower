using ControlPlots
# Re = 3.8e4

# x: speed ratio
# x = ωR/v_a
function cd(x)
    -0.0211*x^3 + 0.1837*x^2 +1.1183*x+0.5
end

# x: speed ratio
function cl(x)
    0.0126 * x^4 - 0.2004*x^3 + 0.7482*x^2 + 1.3447*x
end

X=1:0.1:5.5
CL = cl.(X)
CD = cd.(X)
LoD = CL ./ CD
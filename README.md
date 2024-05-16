# MagnusPower
Airborne wind energy based on the Magnus effect

## Magnus effect of a rotating cylinder
First, we need to determine the lift and the drag coefficient. This
is done use a polynomial approximation as suggested in [1].

You can plot the result with
```julia
include("src/magnus.jl")
```

## Sizing
Suggested:
- length 2m
- radius 0.2m

--> area 0.8 m²

## Calculate force
- l = 200 m
- v_wind_gnd = 6.0 m/s

2D simulation

## Buoyancy
- volume ~ 0.25 m³
- buoyancy ~ 0.26 kg
- price for helium ~ 0.15 EUR/l


## References

[1] Milan Milutinović, Mirko Čorić, Joško Deur,
*Operating cycle optimization for a Magnus effect-based airborne wind energy system,*
Energy Conversion and Management, Volume 90, 2015



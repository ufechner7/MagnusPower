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

[2] Yashank Gupta. Magnus Based Airborne Wind Energy Systems. Automatic. Université Grenoble
Alpes, 2018. English. NNT : 2018GREAT094. tel-02113723v2

[3] Eduardo Schmidt, Yashank Gupta, Jonathan Dumon, Ahmad Hably. In-flight estimation of the
aerodynamic characteristics of a Magnus effect-based airborne wind energy system. REDEC 2018 -
International Conference on Renewable Energies for Developing countries (REDEC 2018), Nov 2018,
Beyrouth, Lebanon. 10.1109/REDEC.2018.8598022. hal-01895342



# Spiral 3D: 3D volumetric spiral 

_x = Vector[x]      , _y = Vector[y]            , _z = Vector[z]

#The distance from origin after 1 turn of the spiral
_oneTurnDist = 1/Curviness{0.5}
_arms = floor(Arms{2})

#The distance of this 'point' from the origin
_pointRadialDist = (_x**2+_y**2)**0.5

#The angle to this point in relation to the origin
_pointAngle = atan2(_y,_x)+3.141593

#The proportion of this rotation
_pointTurn = _pointAngle / 2 / 3.141593

#The number of completed turns to get to the point distance
_completeTurns = floor((_pointRadialDist / _oneTurnDist - _pointTurn)*_arms)/_arms

#The number of spiral turns to get closed to this point (the two closest tracks)
_innerSpiralTurns = _completeTurns + _pointTurn
_outerSpiralTurns = _completeTurns + 1/_arms + _pointTurn

# The radial distance of this point on the spiral
_innerSpiralRadialDist = _innerSpiralTurns * _oneTurnDist
_outerSpiralRadialDist = _outerSpiralTurns * _oneTurnDist

#Set to 'true' if the 'inner' is closest - else 'outer' is closest
_innerSpiralClosest = abs(_pointRadialDist - _innerSpiralRadialDist) < abs(_pointRadialDist - _outerSpiralRadialDist)

#The distance from this point to the nearest point on the spiral on the z-plane.
_planarDistance = min(abs(_pointRadialDist - _innerSpiralRadialDist),abs(_pointRadialDist - _outerSpiralRadialDist))

#Calculate the distance to the point in 3d space (radial distance)
Distance = (_planarDistance**2+_z**2)**0.5

#How far along the spiral from the centre
Length = _innerSpiralClosest * _innerSpiralTurns + not(_innerSpiralClosest) * _outerSpiralTurns

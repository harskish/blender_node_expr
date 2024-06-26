# Hexagons : Convert 'x' and 'y' coordinates into hexagons, returning the distance to the nearest edge
?Input:Vector,XY,Generated,Object
?Cell Position:Disabled,Enabled
?Centre Distances:Disabled,Enabled

:Input.Vector:    _x=Vector[x],          _y=Vector[y]
:Input.XY:        _x=x,                  _y=y
:Input.Generated: _x=Input.Generated[x], _y=Input.Generated[y]
:Input.Object:    _x=Input.Object[x],    _y=Input.Object[y]

#Set X and Y scaling based on Aspect ratio (0.866 for undistorted hexagons (`sin(60 degrees)`)
_xpitch=Aspect{1.0}/Scale{5}
_ypitch=0.866/Scale

#Logic to control where we need to place the reference points
_firsthalf=mmod(_x,_xpitch)>_xpitch/2
_tophalf=mmod(_y,_ypitch)>_ypitch/2
_oddline=mmod(_y,_ypitch*2)>_ypitch

#Define the reference points - x1 is "main" reference, others positioned in relation to that
_x1=_x-mmod(_x,_xpitch)+_oddline*((-_xpitch/2*0)),  _y1=_y-mmod(_y,_ypitch)+_oddline*_ypitch
_x2=_x1+_xpitch,                                                        _y2=_y1
_x3=(_x1+_x2)/2,                                                        _y3=_y1-_ypitch
_x4=_x3,                                                                      _y4=_y1+_ypitch
_x5=_x3-_xpitch+_xpitch*2*_firsthalf,                     _y5=_y3*not(_tophalf)+_y4*_tophalf

#Distance to each reference point
_d1 = ((_x-_x1)**2+(_y-_y1)**2)**0.5
_d2 = ((_x-_x2)**2+(_y-_y2)**2)**0.5
_d3 = ((_x-_x3)**2+(_y-_y3)**2)**0.5
_d4 = ((_x-_x4)**2+(_y-_y4)**2)**0.5
_d5 = ((_x-_x5)**2+(_y-_y5)**2)**0.5

#Distance to the closest point
_dist = min(_d1,_d2,_d3,_d4,_d5)

#Determine which of the reference point is the closest
_closest1 = (_dist == _d1)
_closest2 = not(_closest1)*(_dist == _d2)
_closest3 = not(or(_closest1,_closest2))*(_dist == _d3)
_closest4 = not(or(_closest1,_closest2,_closest3))*(_dist == _d4)
_closest5 = not(or(_closest1,_closest2,_closest3,_closest4))

#Determine the distance to the *next* closest
_nextdist = max(_closest1*min(_d2, _d3, _d4, _d5)
              _closest2*min(_d1, _d3, _d4, _d5)
              _closest3*min(_d1, _d2, _d4, _d5)
              _closest4*min(_d1, _d2, _d3, _d5)
              _closest5*min(_d1, _d2, _d3, _d4, _d5))

##Determine which of the points is the next closest
#_nextclosest1 = (_d1 == _nextdist)*not(_closest1)
#_nextclosest2 = (_d2 == _nextdist)*not(_closest2)*not(_nextclosest1)
#_nextclosest3 = (_d3 == _nextdist)*not(_closest3)*not(or(_nextclosest1,_nextclosest2))
#_nextclosest4 = (_d4 == _nextdist)*not(_closest4)*not(or(_nextclosest1,_nextclosest2,_nextclosest3))
#_nextclosest5 = not(_closest5)*not(or(_nextclosest1,_nextclosest2,_nextclosest3,_nextclosest4))

#Calculate how close we are to the edge (the edge is halfway between the two distances)
Hexagon = 1-(_dist /((_nextdist + _dist)/2))

:Centre Distances.Enabled:#Additional outputs
:Centre Distances.Enabled:DistanceFromCentre = _dist
:Centre Distances.Enabled:DistanceFromNextCentre = _nextdist

:Cell Position.Enabled:CellPos[]=combine(_closest1*_x1 + _closest2*_x2 + _closest3*_x3 + _closest4*_x4 + _closest5*_x5, _closest1*_y1 + _closest2*_y2 + _closest3*_y3 + _closest4*_y4 + _closest5*_y5, 0)
# Spiral 2D: 2D spiral 
?Input:Vector,XY,Object,UV,UV(Recentered)

:Input.Vector:  _x = Vector[x]      , _y = Vector[y]
:Input.XY:      _x = x              , _y = y
:Input.Object:  _x = Input.Object[x], _y = Input.Object[y]
:Input.UV:              _x = Input.UV[x]        , _y = Input.UV[y]
:Input.UV(Recentered):  _x = Input.UV[x]-0.5    , _y = Input.UV[y]-0.5

_dist=(_x**2+_y**2)**0.5
_angle=atan2(_y,_x)/3.141/2+0.5

Output=mmod(_angle*Turns{5}+_dist*Curviness{1},1)

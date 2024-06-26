# Scales : Overlapping scales
?Input:Vector,XY

:Input.Vector: _x = Vector[x], _y = Vector[y]
:Input.XY:     _x = x, _y = y

CentreX=_x1*_hit1+_x2*_hit2+_x1*_hit3+_x2*_hit4, 
CentreY=_y1*_hit1+_y1*_hit2+_y2*_hit3+_y2*_hit4, 
_x1=_x-mod(_x,Size{0.17}), 
_x2=_x1+Size, 
_y1=_y-mod(_y,Size), 
_y2=_y1+Size, 
_d1 = ((_x-_x1)**2+(_y-_y1)**2)**0.5, 
_d2 = ((_x-_x2)**2+(_y-_y1)**2)**0.5, 
_d3 = ((_x-_x1)**2+(_y-_y2)**2)**0.5, 
_d4 = ((_x-_x2)**2+(_y-_y2)**2)**0.5, 
_hit1 = _d1 < Radius, 
_hit2 = (1-_hit1) * (_d2 < Radius), 
_hit3 = (1-max(_hit1,_hit2)) * (_d3 < Radius), 
_hit4 = (1-max(_hit1,max(_hit2,_hit3))) * (_d4 < Radius), 
_hitNone = (1-max(_hit1,max(_hit2,max(_hit3,_hit4)))), 
_distToHit = _d1 * _hit1 + _d2 * _hit2 + _d3 *_hit3 + _d4*_hit4 + 99999*_hitNone, 
Value=abs(_distToHit-Radius{0.13})<Thickness{0.005}
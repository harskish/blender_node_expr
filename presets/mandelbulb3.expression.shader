# (New)Mandelbulb3 : Generate a Mandelbulb(Re-developed) (3d-mandelbrot)
?Input:Vector,Generated,Object
?Density:Enabled,Disabled
?Direction:Disabled,Enabled
?OldFormula:Disabled,Enabled
?Iterations:5,6,12,20

#Define the group for one 'iteration' of the Mandelbulb calculation
group:start(mandelbulbiteration, N, iBlown, Limit, iOffset[], iVector[], ROffset, ThetaOffset, PhiOffset, PrevDirection[])

#Split the input vector into x,y,z
_x = iVector[x],   _y = iVector[y],   _z = iVector[z]

##Calculate the coordinates
#_r = (_x*_x + _y*_y + _z*_z)**0.5 - ROffset
#_theta = atan2((_x*_x+_y*_y)**0.5,_z) + ThetaOffset
#_phi = atan2(_y,_x) + PhiOffset
#
#_rn = _r ** N
#
#_newx = _rn * sin(_theta*N) * cos(_phi*N)
#_newy = _rn * sin(_theta*N) * sin(_phi*N)
#_newz = _rn * cos(_theta*N)

#Code derived from https://www.iquilezles.org/www/articles/mandelbulb/mandelbulb.htm
#extract polar coordinates
_r = (_x*_x + _y*_y + _z*_z)**0.5 - ROffset
_theta = acos(_y/_r) + ThetaOffset
_phi = atan2(_x,_z) + PhiOffset

#scale and rotate the point
_rn= _r ** N
_thetaN = _theta * N
_phiN = _phi * N

#convert back to cartesian coordinates
_newx = _rn * sin(_thetaN)*sin(_phiN)
_newy = _rn * cos(_thetaN)
_newz = _rn * sin(_thetaN)*cos(_phiN)

#New distance from centre
_newR = (_newx*_newx + _newy*_newy + _newz*_newz)**0.5

#Determine whether our new point lies outside the sphere
oBlown = or(iBlown, _newR> Limit) 

oVector[] = vadd(combine(_newx, _newy, _newz), iOffset[])

Direction[] = mix(iBlown,combine(_x-_newx, _y-_newy, _z-_newz),PrevDirection) 
DirectionChange = vdot(vnorm(Direction[]), vnorm(PrevDirection))

#End the group - the name should match the 'start'
group:end(mandelbulbiteration) 

#-----------------------------------------------------------------------------------------

:Input.Vector:    _vector[] = Vector[]
:Input.Generated: _vector[] = Input.Generated
:Input.Object:    _vector[] = Input.Object

#Add a group node named 'iteration1', setting the inputs to the group input values
#group:add(mandelbulbiteration,iteration1,N{8},0,Limit{2},_vector[], _vector[], ROffset, ThetaOffset, PhiOffset, combine(0,0,0))
#NOTE : Above was possibly inaccurate due to including the vector as the start point
:OldFormula.Enabled: group:add(mandelbulbiteration,iteration1,N{8},0,Limit{2},_vector[], _vector[], ROffset, ThetaOffset, PhiOffset, combine(0,0,0))
:OldFormula.Disabled: group:add(mandelbulbiteration,iteration1,N{8},0,Limit{2},combine(0,0,0), _vector[], ROffset, ThetaOffset, PhiOffset, combine(0,0,0))

#Add second group node named iteration2 and linked to the first
group:add(mandelbulbiteration,iteration2,N,group:iteration1[oBlown],Limit,_vector[], group:iteration1[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration1[Direction])

#Add some more iterations
group:add(mandelbulbiteration,iteration3,N,group:iteration2[oBlown],Limit,_vector[], group:iteration2[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration2[Direction])
group:add(mandelbulbiteration,iteration4,N,group:iteration3[oBlown],Limit,_vector[], group:iteration3[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration3[Direction])
group:add(mandelbulbiteration,iteration5,N,group:iteration4[oBlown],Limit,_vector[], group:iteration4[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration4[Direction])
group:add(mandelbulbiteration,iteration6,N,group:iteration5[oBlown],Limit,_vector[], group:iteration5[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration5[Direction])
group:add(mandelbulbiteration,iteration7,N,group:iteration6[oBlown],Limit,_vector[], group:iteration6[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration6[Direction])
group:add(mandelbulbiteration,iteration8,N,group:iteration7[oBlown],Limit,_vector[], group:iteration7[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration7[Direction])
group:add(mandelbulbiteration,iteration9,N,group:iteration8[oBlown],Limit,_vector[], group:iteration8[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration8[Direction])
group:add(mandelbulbiteration,iteration10,N,group:iteration9[oBlown],Limit,_vector[], group:iteration9[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration9[Direction])
group:add(mandelbulbiteration,iteration11,N,group:iteration10[oBlown],Limit,_vector[], group:iteration10[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration10[Direction])
group:add(mandelbulbiteration,iteration12,N,group:iteration11[oBlown],Limit,_vector[], group:iteration11[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration11[Direction])
group:add(mandelbulbiteration,iteration13,N,group:iteration12[oBlown],Limit,_vector[], group:iteration12[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration12[Direction])
group:add(mandelbulbiteration,iteration14,N,group:iteration13[oBlown],Limit,_vector[], group:iteration13[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration13[Direction])
group:add(mandelbulbiteration,iteration15,N,group:iteration14[oBlown],Limit,_vector[], group:iteration14[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration14[Direction])
group:add(mandelbulbiteration,iteration16,N,group:iteration15[oBlown],Limit,_vector[], group:iteration15[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration15[Direction])
group:add(mandelbulbiteration,iteration17,N,group:iteration16[oBlown],Limit,_vector[], group:iteration16[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration16[Direction])
group:add(mandelbulbiteration,iteration18,N,group:iteration17[oBlown],Limit,_vector[], group:iteration17[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration17[Direction])
group:add(mandelbulbiteration,iteration19,N,group:iteration18[oBlown],Limit,_vector[], group:iteration18[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration18[Direction])
group:add(mandelbulbiteration,iteration20,N,group:iteration19[oBlown],Limit,_vector[], group:iteration19[oVector], ROffset, ThetaOffset, PhiOffset, group:iteration19[Direction])

:Iterations.20: _oBlown = group:iteration20[oBlown]
:Iterations.20: _DirectionChange = group:iteration20[DirectionChange]
:Iterations.20: _Direction = group:iteration20[Direction]

:Iterations.12: _oBlown = group:iteration12[oBlown]
:Iterations.12: _DirectionChange = group:iteration12[DirectionChange]
:Iterations.12: _Direction = group:iteration12[Direction]

:Iterations.6: _oBlown = group:iteration6[oBlown]
:Iterations.6: _DirectionChange = group:iteration6[DirectionChange]
:Iterations.6: _Direction = group:iteration6[Direction]

:Iterations.5: _oBlown = group:iteration5[oBlown]
:Iterations.5: _DirectionChange = group:iteration5[DirectionChange]
:Iterations.5: _Direction = group:iteration5[Direction]
    
#Define the outputs
Inside = not(_oBlown)
:Density.Enabled:    Density = Inside * DensityMultiplier{30}
Volatility = acos(_DirectionChange) / "pi"
:Direction.Enabled: Direction[] = vnorm(_Direction)
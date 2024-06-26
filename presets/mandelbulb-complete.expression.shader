# Mandelbulb : Generate a Mandelbulb (3d-mandelbrot)

#Define the group for one 'iteration' of the Mandelbulb calculation
group:start(mandelbulbiteration, N, iBlown, Limit, iOffset[], iVector[])

#Split the input vector into x,y,z
_x = iVector[x]
_y = iVector[y]
_z = iVector[z]

#Calculate the coordinates
_r = (_x*_x + _y*_y + _z*_z)**0.5
_theta = atan2((_x*_x+_y*_y)**0.5,_z)
_phi = atan2(_y,_x)

_rn = _r ** N

_newx = _rn * sin(_theta*N) * cos(_phi*N)
_newy = _rn * sin(_theta*N) * sin(_phi*N)
_newz = _rn * cos(_theta*N)

#New distance from centre
_newR = (_newx*_newx + _newy*_newy + _newz*_newz)**0.5

#Determine whether our new point lies outside the sphere
oBlown = or(iBlown, _newR> Limit) 

oVector[] = vadd(combine(_newx, _newy, _newz), iOffset[])
Intensity = _r - _newR

#End the group - the name should match the 'start'
group:end(mandelbulbiteration) 

#-----------------------------------------------------------------------------------------

#Add a group node named 'iteration1', setting the inputs to the group input values
group:add(mandelbulbiteration,iteration1,N{8},0,Limit{2},Input[], Input[])

#Add second group node named iteration2 and linked to the first
group:add(mandelbulbiteration,iteration2,N,group:iteration1[oBlown],Limit,Input[], group:iteration1[oVector])

#Add some more iterations
group:add(mandelbulbiteration,iteration3,N,group:iteration2[oBlown],Limit,Input[], group:iteration2[oVector])
group:add(mandelbulbiteration,iteration4,N,group:iteration3[oBlown],Limit,Input[], group:iteration3[oVector])
group:add(mandelbulbiteration,iteration5,N,group:iteration4[oBlown],Limit,Input[], group:iteration4[oVector])
group:add(mandelbulbiteration,iteration6,N,group:iteration5[oBlown],Limit,Input[], group:iteration5[oVector])
group:add(mandelbulbiteration,iteration7,N,group:iteration6[oBlown],Limit,Input[], group:iteration6[oVector])
group:add(mandelbulbiteration,iteration8,N,group:iteration7[oBlown],Limit,Input[], group:iteration7[oVector])
group:add(mandelbulbiteration,iteration9,N,group:iteration8[oBlown],Limit,Input[], group:iteration8[oVector])
group:add(mandelbulbiteration,iteration10,N,group:iteration9[oBlown],Limit,Input[], group:iteration9[oVector])
    
#Define the outputs
Inside = not(group:iteration10[oBlown])
Intensity = group:iteration10[Intensity]
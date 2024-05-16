# Test : Test that all the operators work correctly 

# Vectors as input don't seem to work
#inputs(val1, val2, val3, vec1[], vec2[], vec3[])

# This seems to drop the last variable! (possibly it's just that it isn't actually used...?)
inputs(val1, val2, val3, vec1, vec2, vec3)

#Maths
Add = val1 + val2
Subtract = val1 - val2
Multiply = val1 * val2
Divide = val1 / val2
Power = val1 ** val2
Log = log(val1, val2)
Sine = sin(val1)
Cosine = cos(val1)
Trangent = tan(val1)
Arcsine = asin(val1)
Arccosine = acos(val1)
Arctangent = atan(val1)
Arctangent2 = atan2(val1, val2)
Modulo = mod(val1, val2)
Absolute = abs(val1)

Max = max(val1, val2)
MultiMax = max(val1, val2, val3)
Min = min(val1, val2)
MultiMin = min(val1, val2, val3)
Greater = val1 > val2
GreaterEqual = val1 >= val2
Less = val1 < val2
LessEqual = val1 <= val2
Equal = val1 == val2

NotEqual = val1 <> val2
#This doesn't seem to be working!!! (although same input value!)
NotEqual2 = val2 <> val2

#Vector Maths
VectorAdd = vadd(vec1, vec2)
VectorSubtract = vsub(vec1, vec2)
VectorMultiply = vmult(vec1, vec2)
VectorDivide = vdiv(vec1, vec2)

#Other Stuff
Colorramp = colorramp(val1, 0, combine(0,0,0), 0.25, combine(1,0,0), 0.5, combine(0,1,0), 0.75, combine(0,0,1), 1.0, combine(0,0.0))
Noise = noise(vec1, 12)
Voronoi = voronoi(vec1,12)


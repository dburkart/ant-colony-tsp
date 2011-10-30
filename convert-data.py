from math import sqrt
import sys

def getInfo( S ):
    if S.count( ':' ):
        return [ S[ 0 : S.index( ' : ' ) ], S[ S.index( ':' ) + 2 : len( S ) - 1 ] ]
    else:
        return False

def getCoord( S ):
    if ( S == 'EOF' ):
        return False
    else:
        first = S.index( ' ' )
        second = S.index( ' ', first + 1 )
        return [ float( S[ first : second ] ), float( S[ second : len( S ) - 1 ] ) ]

data = open( sys.argv[1] , 'r' )
info = {}

d = getInfo( data.readline() )
while ( d ):
    if ( d[0] in info ):
        info[d[0]] += "\n" + d[1]
    else:
        info[d[0]] = d[1]

    d = getInfo( data.readline() )

dimension = 0
if ( 'DIMENSION' in info ):
    dimension = int( info[ 'DIMENSION' ] )

coords = list()
for i in range( dimension ):
    coords.append( getCoord( data.readline() ) )

f = open( 'data.txt', 'w' )

matrix = [ [ 0 for i in range( dimension ) ] for j in range( dimension ) ]
for i in range( dimension ):
    a = coords[ i ]
    for j in range( i ):
        b = coords[ j ]
        matrix[ i ][ j ] = matrix[ j ][ i ] = sqrt( pow( (a[0] - b[0]), 2 ) + pow( (a[1] - b[1]), 2 ) )

f.write( 'adj_matrix = [ ' )
for i in range( dimension ):
    for j in range( dimension ):
        f.write( str( matrix[ i ][ j ] ) + ' ' )
    f.write( ";\n" )

f.write( " ]\n" )

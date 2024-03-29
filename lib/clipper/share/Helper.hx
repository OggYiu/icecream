package clipper.share;

import nme.geom.Matrix;

import clipper.share.Defines;

class Helper {
	static private inline var MIN_FLOAT : Float = 0.0001;
	static private inline var RAD_TO_DEGREE : Float = 57.2957795;
	static private inline var DEGREE_TO_RAD : Float = 0.0174532925;

	public function new() {
	}

	public static function isZero( value : Float ) : Bool {
		return Math.abs(value) >= 0 && Math.abs(value) <= MIN_FLOAT;
	}

	public static function isEqualF ( a : Float, b : Float ) : Bool {
  		if ( Math.abs ( a - b ) < 1E-12 ) {
    		return true;
  		}

  		return false;
	}

	public static function randInRangeF ( x : Float, y : Float ) : Float {
  		return x + Math.random() * ( y - x );
	}

	public static function randInRangeInt ( x : Int, y : Int ) : Int {
  		return Std.int ( x + Math.random() * ( y - x ) );
	}

	static function S4() : String { 
   		return ( ( ( 1 + Std.int( Math.random() * 100 ) * 0x10000) | 0 ) + "" ).substring(1); 
	} 

	public static function guid() : String { 
   		return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4()); 
  	}

	public static function getMatrixWithOrientation( orientation : Orientation, width : Int, height : Int ) : Matrix { 
		switch( orientation ) {
			case Orientation.none:
				return new Matrix( 1, 0, 0, 1, 0, 0 );
			case Orientation.flipH:
				return new Matrix( -1, 0, 0, 1, width, 0 );
			case Orientation.flipV:
				return new Matrix( 1, 0, 0, -1, 0, height );
			case Orientation.flipHV:
				return new Matrix( -1, 0, 0, -1, width, height );
		}

		return null;
	}

	inline public static function degToRad( degree : Float ) {
		return degree * DEGREE_TO_RAD;
	}

	inline public static function radToDeg( rad : Float ) {
		return rad * RAD_TO_DEGREE;
	}

	inline public static function rotateVec( output : Dynamic, degree : Float ) : Void {
		var theta : Float = degree;
		theta = Helper.degToRad(theta);
		var cs : Float = Math.cos(theta);
		var sn : Float = Math.sin(theta);
		var px : Float = output.x * cs - output.y * sn;
		var py : Float = output.x * sn + output.y * cs;
		output.x = px;
		output.y = py;

		trace( "px: " + px );
		trace( "py: " + py );
	}
}
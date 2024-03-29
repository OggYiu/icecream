package ;

import firerice.core.Kernal;
import haxe.Timer;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author oggyiu
 */

class Main extends Sprite 
{
	var lastUpdateTime_ : Float = 0;
	var updated_ : Bool = false;
	var kernal_ : Kernal = null;
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
		
		addEventListener( Event.ENTER_FRAME, update );
		
		kernal_ = new Kernal( this );
	}

	private function init(e) 
	{
	}
	
	private function update( event : Event ) : Void {
		var dt : Float = 0;
		if ( !updated_ ) {
			updated_ = true;
		} else {
			dt = Timer.stamp() - lastUpdateTime_;
		}
		lastUpdateTime_ = Timer.stamp();
		
		kernal_.update( dt );
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}

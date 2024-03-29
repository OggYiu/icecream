package firerice.core;

import firerice.common.Helper;
import firerice.components.Component;
import firerice.components.SpriteComponent;
import firerice.components.TransformComponent;
import firerice.core.Process;
import firerice.interfaces.IComponentContainer;
import firerice.interfaces.IDisplayable;
import firerice.interfaces.IEntityCollection;
import firerice.types.EEntityType;
import haxe.xml.Fast;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.IEventDispatcher;

/**
 * ...
 * @author oggyiu
 */

class Entity extends Process, implements IEntityCollection, implements IComponentContainer, implements IDisplayable, implements IEventDispatcher
{
	public var context( default, null ) : Sprite = null;
	public var entities( default, null ) : Hash<Entity> = null;
	public var components( default, null ) : Hash<Component> = null;
	public var type( default, null ) : EEntityType;
	public var parent( default, null ) : Dynamic = null;
	
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id );
		
		//type = EntityType.unknown;
		parent = p_parent;
		
		if ( context == null ) {
			context = new Sprite();
		}
		
		if ( parent != null ) {
			if ( Std.is( parent, IEntityCollection ) ) {
				parent.addChild( this );
			}
			if ( Std.is( parent, IDisplayable ) ) {
				parent.context.addChild( context );
			}
		}
		
		//this.context.addEventListener( Event.RENDER, onRender );
		//CEntityCollection.setAddChild( this );
		
		entities = new Hash<Entity>();
		components = new Hash<Component>();
	}
	
	public function load( xml : Xml ) {
		if ( xml != null ) {
			initEntity( xml );
		} else {
			Helper.assert( false, "<Entity::init_>, xml for init not found!" );
		}
		
		//resolved();
	}
	
	// establish the relationship between component
	//function resolved() : Void {
		//for ( component1 in components ) {
			//for ( component2 in components ) {
				//if ( component1 == component2 ) {
					//continue;
				//}
				//
				//component1.resolve( component2 );
			//}
		//}
	//}
	
	override private function update_( dt : Float ) : Void {
		for( component in components ) {
			component.update( dt );
		}
		
		for ( entity in entities ) {
			entity.update( dt );
		}
	}
	
	public function addComponent( component : Component ) : Void {
		#if debug
		if ( components.get( component.id ) != null ) {
			Helper.assert( false, "<Entity::addComponent>, component: " + component.id + " already existed!" );
			return ;
		}
		#end
		
		components.set( component.id, component );
	}
	
	public function hasComponent( componentId : String ) : Bool {
		return components.exists( componentId );
	}
	
	public function getComponent( componentId : String ) : Component {
		return components.get( componentId );
	}
	
	function initEntity( xml : Xml ) : Void {
		// get the first element "actor"
		var firstElem : Fast = new haxe.xml.Fast( xml.firstElement() );
		//type = strToEntityType(firstElem.att.type);
		
		//var content = haxe.Resource.getString("data_xml");
		var root = xml.firstElement();
		var elements = root.elements();
		while( elements.hasNext() )
		{
			var targetXml : Xml = elements.next();
			var targetNodeName : String = targetXml.nodeName;
			this.addComponent( readComponent( targetXml ) );
		}
		
		trace( "<Entity::initEntity>, type: " + type );
	}
	
	function readComponent( xml : Xml ) : Component {
		switch( xml.nodeName ) {
			case TransformComponent.ID: {
				// read  position
				var positionXml : Xml = xml.firstElement();
				var firstElem : Fast = new haxe.xml.Fast( positionXml );
				
				return new TransformComponent(	this, 
												Std.parseFloat( firstElem.att.x ),
												Std.parseFloat( firstElem.att.y ),
												Std.parseFloat( firstElem.att.z ) );
			}
			case SpriteComponent.ID: {
				var elements = xml.elements();
				var texturePath : String = "";
				var texturePaths : Array<String> = new Array<String>();
				while ( elements.hasNext() ) {
					var elem : Xml = elements.next();
					
					switch( elem.nodeName ) {
						case SpriteComponent.TEXTURE: texturePaths.push( elem.firstChild().nodeValue.toString() );
					}
				}
				
				//var l_context : Sprite = new Sprite();
				//l_context.addChild( new Bitmap( Assets.getBitmapData( texturePath ) ) );
				var bitmapDataCollection : Array<BitmapData> = new Array<BitmapData>();
				for ( texturePath in texturePaths ) {
					bitmapDataCollection.push( Assets.getBitmapData( texturePath ) );
				}
				return new SpriteComponent( this, bitmapDataCollection );
			}
		}
		
		#if debug
		Helper.assert( false, "<Entity::readComponent>, " + xml.nodeName + " not handled" );
		#end
		return null;
	}
	
	public function addChild( entity : Entity ) : Void {
		#if debug
		Helper.assert( !entities.exists( entity.id ), "entity already existed: " + entity.id );
		#end
		
		entities.set( entity.id, entity );
	}
	
	//public static function strToEntityType( str : String ) : EEntityType {
		//switch( str ) {
			//case TransformComponent.name: return EntityType.transform;
		//}
		//
		//#if debug
		//Helper.assert( false, "<Entity::strToEntityType>, no entity type is found for string : " + str );
		//#end
		//
		//return EntityType.unknown;
	//}
	
	public function addEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
	// public function addEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false, ?priority : Int = 0, ?useWeakReference : Bool = false) : Void {
		this.context.addEventListener( type , listener , useCapture , priority , useWeakReference );
	}
	
	public function dispatchEvent(event : Event) : Bool {
		return this.context.dispatchEvent( event );
	}
	
	public function hasEventListener(type : String) : Bool {
		return this.context.hasEventListener( type );
	}

	public function removeEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false) : Void {
	// public function removeEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false) : Void {
		this.context.removeEventListener( type , listener , useCapture );
	}
	
	public function willTrigger(type : String) : Bool {
		return this.context.willTrigger( type );
	}
}
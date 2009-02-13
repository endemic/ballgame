package {
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	
	public class Cursor extends Sprite {
		
		static public var main:Object;
		
		// Constructor
		public function Cursor():void {
			//Mouse.hide();
			main = this;
			this.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		// Updates representation of the cursor
		public function onMove(e:MouseEvent):void {
			this.x = stage.mouseX;
			this.y = stage.mouseY;
		}
	}
}
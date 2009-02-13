package {
	import flash.display.Sprite;
	
	public class Block extends Sprite {
		
		static public var list:Array = [];
		
		public var type:String;
		
		private var spriteContainer:Sprite;
		
		public function Block(_width:int, _height:int, _type:String, _x:int, _y:int):void {
			// Set variables based on what's passed to the constructor
			this.type = _type;
			this.x = _x;
			this.y = _y;
			
			// Load graphic
			spriteContainer = new Sprite();
			spriteContainer.graphics.beginFill(0x00ff00);
			spriteContainer.graphics.drawRect(0, 0, _width, _height);
			spriteContainer.graphics.endFill();
			this.addChild(spriteContainer);
			
			// Add to list
			list.push(this);
			
			// Add to main display list
			Game.main.spriteContainer.addChild(this);
		}
		
		public function destroy():void {
			// Remove this object
			if(Game.main.spriteContainer.contains(this))
				Game.main.spriteContainer.removeChild(this);
		}
	}
}
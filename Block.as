package {
	import flash.display.Sprite;
	
	public class Block extends Sprite {
		
		static public var size:int = 20;
		static public var list:Array = [];
		static public var types:Object = {
			1:"Solid",
			2:"Collectable",
			3:"Start",
			4:"Exit"
		};
		
		public var type:String;
		
		[Embed(source="graphics/block.svg")]
		private var BlockGraphic:Class;
		private var spriteContainer:Sprite;
		
		public function Block(_type:String, _x:int, _y:int):void {
			// Set variables based on what's passed to the constructor
			this.type = _type;
			this.x = _x;
			this.y = _y;
			
			// Load graphic
			spriteContainer = new Sprite();
			var s:Sprite = new BlockGraphic();
			s.width = Block.size;
			s.height = Block.size;
			s.cacheAsBitmap = true;
			// Center reference point
			//s.x = -this.size / 2;
			//s.y = -this.size / 2;
			spriteContainer.addChild(s);
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
			
			// Remove from array as well
			for(var i:int = 0; i < list.length; i++)
				if(list[i] == this)
					list.splice(i, 1);
		}
	}
}
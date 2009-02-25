package {
	import flash.display.Sprite;
	
	public class Block extends Sprite {
		
		static public var size:int = 20;
		static public var list:Array = [];
		static public var types:Object = {
			1:"Solid",
			2:"Collectable",
			3:"Start",
			4:"Exit",
			5:"LeftSpike",
			6:"RightSpike",
			7:"DownSpike",
			8:"UpSpike"
		};
		
		public var type:String;
		
		[Embed(source="graphics/block.svg")]
		private var BlockGraphic:Class;
		
		[Embed(source="graphics/spike.svg")]
		private var SpikeGraphic:Class;
		
		private var spriteContainer:Sprite;
		
		public function Block(_type:int, _x:int, _y:int):void {
			// Set variables based on what's passed to the constructor
			this.type = types[_type];
			this.x = _x;
			this.y = _y;
			
			// Local sprite variable to load graphic
			var s:Sprite;
			
			// Load graphic
			if(_type > 5) {
				s = new SpikeGraphic();
				
				// Allow for different directions
				if(_type == 5) {
					s.rotation -= 90;
					s.x -= s.height;
				} else if(_type == 6) {
					s.rotation += 90;
					s.x -= s.height;
				} else if(_type == 7)
					s.rotation += 180;
			} else {
				s = new BlockGraphic();
			}
				
			s.width = Block.size;
			s.height = Block.size;
			s.cacheAsBitmap = true;
			
			spriteContainer = new Sprite();
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
package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	[SWF(frameRate='30',width='640',height='480',backgroundColor='0xffffff')]
	
	public class Game extends Sprite {
		
		static public var main:Object;
		public var spriteContainer:Sprite = new Sprite();
		public var ball:Ball;
		public var mapData:Array;
		public var mapLayer:Sprite = new Sprite();
		public var mouseClicked:Boolean = false;
		public var debug:DebugText;
		
		public function Game():void {
			main = this;
			//var mouse:Cursor = new Cursor();
			
			// Create ball
			ball = new Ball();
			ball.init();
			spriteContainer.addChild(ball);
			spriteContainer.addChild(mapLayer);
			
			//spriteContainer.graphics.beginFill(0xFFFFFF);
			//spriteContainer.graphics.drawRect(0, 0, 640, 480);
			//spriteContainer.graphics.endFill();
			
			// 640 x 480 resolution equals 32 x 24 20 pixel blocks
			mapData = [
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5],
			[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5],
			[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5],
			[1,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,0,0,0,0,6,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,1,1,1,7,7,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1]
			];
			
			// DEBUG - add some blocks
			var block:Block;
			var coin:Collectable;

			for(var row:* in mapData)
				for(var col:* in mapData[row])
					if(mapData[row][col] != 0) {
						
						// Place collectables
						if(mapData[row][col] == 2) {
							coin = new Collectable(col * Block.size, row * Block.size);
							mapData[row][col] = 0;
						// Place player start
						} else if(mapData[row][col] == 3) {
							ball.x = col * Block.size;
							ball.y = row * Block.size;
							mapData[row][col] = 0;
						// Otherwise, place all other blocks
						} else
							block = new Block(mapData[row][col], col * Block.size, row * Block.size);
						
					}
					
			// Create debug text
			debug = new DebugText('DEBUG', 20, 20);

			this.addChild(spriteContainer);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function mouseDown(e:MouseEvent):void {
			mouseClicked = true;
		}
		
		public function mouseUp(e:MouseEvent):void {
			mouseClicked = false;
		}
		
		public function enterFrame(e:Event):void {
			if(mouseClicked == true) {
				// Find distance between mouse and ball; apply velocity
				var angle:Number = Math.atan2(this.mouseY - ball.y, this.mouseX - ball.x);
				
				// Acceleration of ball is inverse of how close cursor is to ball
				var multiplier:Number = 100 / ball.getDistanceFrom(this.mouseX, this.mouseY);
				
				// Make these values negative, so the object moves AWAY from the cursor
				ball.ddx = -Math.cos(angle) * multiplier;
				ball.ddy = -Math.sin(angle) * multiplier;
				
				// Limit max acceleration
				ball.ddx = (ball.ddx >= Block.size) ? Block.size - 2 : ball.ddx;
				ball.ddy = (ball.ddy >= Block.size) ? Block.size - 2 : ball.ddy;
				
				Game.main.debug.message.text = String('(' + this.mouseX + ',' + this.mouseY + ')');
			} else {
				ball.ddx = 0;
				ball.ddy = 0;
			}
		}
	}
}
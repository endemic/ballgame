package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	[SWF(frameRate='30',width='640',height='480',backgroundColor='0xffffff')]
	
	public class Game extends Sprite {
		
		static public var main:Object;
		public var spriteContainer:Sprite;
		public var ball:Ball;
		public var mouseClicked:Boolean = false;
		public var debug:DebugText;
		
		public function Game():void {
			main = this;
			spriteContainer = new Sprite;
			//var mouse:Cursor = new Cursor();
			
			// Create debug text
			debug = new DebugText('DEBUG', 10, 10);
			
			// Create ball
			ball = new Ball();
			ball.init();
			ball.width = 10;
			ball.height = 10;
			spriteContainer.addChild(ball);
			
			spriteContainer.graphics.beginFill(0xFFFFFF);
			spriteContainer.graphics.drawRect(0, 0, 640, 480);
			spriteContainer.graphics.endFill();
			
			// DEBUG - add some blocks
			var block:Block;
			for(var i:int = 0; i < 100; i++)
				block = new Block(10, 10, 'Green', i * 10, i * 10);
			
			// DEBUG - add some collectables
			var coin:Collectable;
			for(i = 5; i < 15; i++)
				coin = new Collectable(i * 20, i * 20);
			// Meat Boy uses array-based levels
			
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
			} else {
				ball.ddx = 0;
				ball.ddy = 0;
			}
		}
	}
}
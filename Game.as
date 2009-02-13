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
		
		public function Game():void {
			main = this;
			spriteContainer = new Sprite;
			//var mouse:Cursor = new Cursor();
			
			// Create ball
			ball = new Ball();
			ball.init();
			spriteContainer.addChild(ball);
			
			spriteContainer.graphics.beginFill(0xFFFFFF);
			spriteContainer.graphics.drawRect(0, 0, 640, 480);
			spriteContainer.graphics.endFill();
			
			this.addChild(spriteContainer);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function mouseDown(e:MouseEvent):void {
			mouseClicked = true;
			var debug:FadeText = new FadeText(String(ball.dx + ", " + ball.dy), this.mouseX, this.mouseY);
		}
		
		public function mouseUp(e:MouseEvent):void {
			mouseClicked = false;
		}
		
		public function enterFrame(e:Event):void {
			if(mouseClicked == true) {
				// Find distance between mouse and ball; apply velocity
				var angle:Number = Math.atan2(this.mouseY - ball.y, this.mouseX - ball.x);

				// Make these values negative, so the object moves AWAY from the cursor
				ball.dx = -Math.cos(angle) * 2;
				ball.dy = -Math.sin(angle) * 2;
			}
		}
	}
}
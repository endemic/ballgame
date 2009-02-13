package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	[SWF(frameRate='30',width='640',height='480',backgroundColor='0xffffff')]
	
	public class Game extends Sprite {
		
		static public var main:Object;
		public var spriteContainer:Sprite;
		public var ball:Ball;
		
		public function Game():void {
			main = this;
			spriteContainer = new Sprite;
			this.addChild(spriteContainer);
			//var mouse:Cursor = new Cursor();
			
			ball = new Ball();
			spriteContainer.addChild(ball);
			
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function onClick(e:MouseEvent):void {
			ball.x = stage.mouseX;
			ball.y = stage.mouseY;
		}
		
		public function enterFrame(e:Event):void {
		}
	}
}
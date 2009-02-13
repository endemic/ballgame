package {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Ball extends Sprite {
		
		// Public
		public var dx:Number;
		public var dy:Number;
		public var ddx:Number;
		public var ddy:Number;
		
		public var friction:Number = 0.8;
		
		// Private
		[Embed(source="graphics/ball.svg")]
		private var BallGraphic:Class;
		private var spriteContainer:Sprite;
		
		public function Ball():void {
			
			// Initialize graphic
			var s:Sprite = new BallGraphic();
			spriteContainer = new Sprite();
			spriteContainer.addChild(s);
			
			// Center contents
			spriteContainer.x = -spriteContainer.width/2;
			spriteContainer.y = -spriteContainer.height/2;
			
			// Add to display list
			this.addChild(spriteContainer);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function init():void {
			this.x = 320;
			this.y = 240;
			this.dx = this.dy = this.ddx = this.ddy = 0;
		}
		
		private function enterFrame(e:Event):void {
			doMovement();
			checkCollision();
		}
		
		private function doMovement():void {
			//this.dx += this.ddx;
			//this.dy += this.ddy;
			
			// Determine how friction affects speed
			//this.dx = (this.dx <= 0.1 || this.dx >= -0.1) ? 0 : this.dx * friction;
			//this.dy = (this.dy <= 0.1 || this.dy >= -0.1) ? 0 : this.dy * friction;
			
			// Apply speed to object
			this.x += this.dx;
			this.y += this.dy;
		}
		
		private function checkCollision():void {
			// Simple - check collision with edges of SWF
			if(this.x <= 0 || this.x >= 640) this.dx = -this.dx;
			if(this.y <= 0 || this.y >= 480) this.dy = -this.dy;
		}
	}
}
package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;

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
		
		[Embed(source="sounds/collision.mp3")]
		private var CollisionSoundEffect:Class;
		
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
			
			// Add acceleration to current speed
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Apply speed to object
			this.x += this.dx;
			this.y += this.dy;
			
			// Determine how friction affects speed
			this.dx = (this.dx <= 0.1 && this.dx >= -0.1) ? 0 : this.dx * friction;
			this.dy = (this.dy <= 0.1 && this.dy >= -0.1) ? 0 : this.dy * friction;
		}
		
		private function checkCollision():void {
			// Simple - check collision with edges of SWF
			if(this.x <= 0 || this.x >= 640) this.dx = -this.dx;
			if(this.y <= 0 || this.y >= 480) this.dy = -this.dy;
			
			// Absolutely prevent from going off the edge of the screen
			if(this.x < 0) this.x = 0;
			if(this.x > 640) this.x = 640;
			if(this.y < 0) this.y = 0;
			if(this.y > 480) this.y = 480;
			
			// Check collision vs. blocks
			for(var i:int = 0; i < Block.list.length; i++) {
				if(this.hitTestObject(Block.list[i])) {
					// Stop any acceleration
					this.ddx = 0;
					this.ddy = 0;
					
					// Bounce the ball away from whatever it hit
					this.dx = -this.dx * 2;
					this.dy = -this.dy * 2;
					
					// Play sound
					var s:Sound = new CollisionSoundEffect() as Sound;
					s.play();
					
					// IDEA - Make movement impossible (or at least much slower) during the "hurt" animation, otherwise the ball 
					// can bounce between objects and get going too fast
					
					// DEBUG
					Game.main.debug.message.text = String('Hit block #' + i);
				}
			}
		}
		
		public function getDistanceFrom(_x:Number, _y:Number):Number {
			return Math.sqrt((this.x - _x) * (this.x - _x) + (this.y - _y) * (this.y - _y));
		}
	}
}
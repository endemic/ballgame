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
			this.dx = (this.dx <= 0.1 && this.dx >= -0.05) ? 0 : this.dx * friction;
			this.dy = (this.dy <= 0.1 && this.dy >= -0.05) ? 0 : this.dy * friction;
		}
		
		private function checkCollision():void {
			
			// Create a temporary object to check collision against
			var tmp:Sprite = this;
			tmp.x += this.dx;
			tmp.y += this.dy;
			
			
			// Check collision vs. blocks
			for(var i:int = 0; i < Block.list.length; i++) {
				if(tmp.hitTestObject(Block.list[i])) {
					// Stop any acceleration/movement
					this.ddx = this.ddy = 0;
					
					// Bounce the ball away from whatever it hit
					// NOTICE: Probably do this for spikes or whatever
					this.dx = -this.dx;
					this.dy = -this.dy;
					
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
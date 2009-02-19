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
		private var collisionSound:Sound = new CollisionSoundEffect() as Sound;
		
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
			
/*			// Apply acceleration
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Apply speed to object
			this.x += this.dx;
			this.y += this.dy;
			
			// Determine how friction/acceleration affects speed
			this.dx = (this.dx <= 0.05 && this.dx >= -0.05) ? 0 : this.dx * friction;
			this.dy = (this.dy <= 0.05 && this.dy >= -0.05) ? 0 : this.dy * friction;*/
			
			doMovement();
		}
		
		// Apply movement
		private function doMovement():void {

			// Add acceleration to current speed
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Apply speed to object
			this.x += this.dx;
			this.y += this.dy;
			
			// Check collision vs. blocks
			for(var i:int = 0; i < Block.list.length; i++) {
				
				// Check in X direction
				if(this.hitTestObject(Block.list[i])) {

					if(this.dx > 0)
						this.x = Block.list[i].x - (this.width / 2);
					else
						this.x = Block.list[i].x + Block.size + (this.width / 2);
					
					// Play sound
					collisionSound.play();
				}
				
				// Check in Y direction
				if(this.hitTestObject(Block.list[i])) {

					if(this.dy < 0)
						this.y = Block.list[i].y - (this.height / 2);
					else
						this.y = Block.list[i].y + Block.size + (this.height / 2);
					
					// Play sound
					collisionSound.play();
				}
				
				// Determine how friction affects speed
				this.dx = (this.dx <= 0.05 && this.dx >= -0.05) ? 0 : this.dx * friction;
				this.dy = (this.dy <= 0.05 && this.dy >= -0.05) ? 0 : this.dy * friction;
			}
		}
		
		
		public function getDistanceFrom(_x:Number, _y:Number):Number {
			return Math.sqrt((this.x - _x) * (this.x - _x) + (this.y - _y) * (this.y - _y));
		}
	}
}
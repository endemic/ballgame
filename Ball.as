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
		
			if(checkCollision('x') == false)
				moveX();
			if(checkCollision('y') == false)
				moveY();
		}
		
		// Apply movement along x vector
		private function moveX():void {
			// Add acceleration to current speed
			this.dx += this.ddx;

			// Apply speed to object
			this.x += this.dx;

			// Determine how friction affects speed
			this.dx = (this.dx <= 0.1 && this.dx >= -0.05) ? 0 : this.dx * friction;
		}
		
		// Apply movement along Y vector
		private function moveY():void {
			// Add acceleration to current speed
			this.dy += this.ddy;
			
			// Apply speed to object
			this.y += this.dy;
			
			// Determine how friction affects speed
			this.dy = (this.dy <= 0.1 && this.dy >= -0.05) ? 0 : this.dy * friction;
		}
		
		private function checkCollision(vector:String):Boolean {
			
			// Create a temporary object to check collision against
			var tmp:Sprite = this;
			
			// If we only want to check vs. x vector
			if(vector == 'x') {
				tmp.x += this.dx + this.ddx;
				tmp.y = this.y;
			// If we only want to check vs. y vector
			} else if(vector == 'y') {
				tmp.y += this.dy + this.ddy;
				tmp.x = this.x;
			}
			
			// Check collision vs. blocks
			for(var i:int = 0; i < Block.list.length; i++) {
				if(tmp.hitTestObject(Block.list[i])) {
					
					// Play sound
					var s:Sound = new CollisionSoundEffect() as Sound;
					s.play();

					// DEBUG
					Game.main.debug.message.text = String('Hit block #' + i);
					
					return true;
				}
			}
			
			return false;
		}
		
		public function getDistanceFrom(_x:Number, _y:Number):Number {
			return Math.sqrt((this.x - _x) * (this.x - _x) + (this.y - _y) * (this.y - _y));
		}
	}
}
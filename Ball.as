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
		
		private function checkCollision(newXPosition:Number, newYPosition:Number):Object
		{
			var corners:Object = new Object();
			corners.downY = Math.floor((newYPosition + this.height - 1) / Block.size);
			corners.upY = Math.floor((newYPosition - this.height) / Block.size);
			corners.leftX = Math.floor((newXPosition - this.width) / Block.size);
			corners.rightX = Math.floor((newXPosition + this.width - 1) / Block.size);
			
			corners.upLeft = Game.main.map[corners.upY][corners.leftX];
			corners.downLeft = Game.main.map[corners.downY][corners.leftX];
			corners.upRight = Game.main.map[corners.upY][corners.rightX];
			corners.downRight = Game.main.map[corners.downY][corners.rightX];
			
			return corners;
		}
		
		// Apply movement
		private function doMovement():void {

			// Add acceleration to current speed
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Move in Y direction
			var tmp:Object = checkCollision(this.x, this.y + this.dy);
			if(this.dy < 0) 
			{
				if(!(tmp.upLeft && tmp.upRight))	// These should both be zero if no block is there
					this.y += this.dy;
				else
					this.y = Math.floor(this.y / Block.size) * Block.size + this.height;
			}
			else if(this.dy > 0)
			{
				if(!(tmp.downLeft && tmp.downRight))	// These should both be zero if no block is there
					this.y += this.dy;
				else
					this.y = (Math.floor(this.y / Block.size) + 1) * Block.size - this.height;
			}
			
			// Move in X direction
			tmp = checkCollision(this.x + this.dx, this.y);
			if(this.dx < 0)
			{
				if(!(tmp.downLeft && tmp.upLeft))	// These should both be zero if no block is there
					this.x += this.dx;
				else
					this.x = Math.floor(this.x / Block.size) * Block.size + this.width;
			}
			else if(this.dx > 0)
			{
				if(!(tmp.downRight && tmp.upRight))	// These should both be zero if no block is there
					this.x += this.dx;
				else
					this.x = (Math.floor(this.x / Block.size) + 1) * Block.size - this.width;
			}
			
			// Determine how friction affects speed
			this.dx = (this.dx <= 0.05 && this.dx >= -0.05) ? 0 : this.dx * friction;
			this.dy = (this.dy <= 0.05 && this.dy >= -0.05) ? 0 : this.dy * friction;
			
		}
		
		
		public function getDistanceFrom(_x:Number, _y:Number):Number {
			return Math.sqrt((this.x - _x) * (this.x - _x) + (this.y - _y) * (this.y - _y));
		}
	}
}
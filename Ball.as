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
			s.width = 20;
			s.height = 20;
			spriteContainer = new Sprite();
			spriteContainer.addChild(s);

			// Center contents
			spriteContainer.x = -spriteContainer.width/2 - 2;
			spriteContainer.y = -spriteContainer.height/2 - 2;
			
			// Add to display list
			this.addChild(spriteContainer);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function init():void {
			this.dx = this.dy = this.ddx = this.ddy = 0;
		}
		
		private function enterFrame(e:Event):void {
			doMovement();
		}
		
		private function checkCollision(newXPosition:Number, newYPosition:Number):Object
		{
			var corners:Object = new Object();
			corners.downY = Math.floor((newYPosition + this.height / 2 - 1) / Block.size);
			corners.upY = Math.floor((newYPosition - this.height / 2) / Block.size);
			corners.leftX = Math.floor((newXPosition - this.width / 2) / Block.size);
			corners.rightX = Math.floor((newXPosition + this.width / 2 - 1) / Block.size);
			
			//Game.main.debug.message.text = String("  " + corners.upY + "\n" + corners.leftX + "  " + corners.rightX + "\n  " + corners.downY);
			
			corners.upLeft = Game.main.map[corners.upY][corners.leftX];
			corners.downLeft = Game.main.map[corners.downY][corners.leftX];
			corners.upRight = Game.main.map[corners.upY][corners.rightX];
			corners.downRight = Game.main.map[corners.downY][corners.rightX];
			
			Game.main.debug.message.text = String(corners.upLeft + " " + corners.upRight + "\n" + corners.downLeft + " " + corners.downRight);
			
			return corners;
		}
		
		// Apply movement
		private function doMovement():void {

			// Add acceleration to current speed
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Move in Y direction
			var tmp:Object = checkCollision(this.x, this.y + this.dy);
			if(this.dy < 0) {
				if(!tmp.upLeft && !tmp.upRight) {	// These should both be zero if no block is there
					this.y += this.dy;
					Game.main.spriteContainer.mapLayer.y -= this.dy;
				} else {
					this.y = Math.floor(this.y / Block.size) * Block.size + this.height / 2;
					this.dy = this.ddy = 0;
					collisionSound.play();
				}
			} else if(this.dy > 0) {
				if(!tmp.downLeft && !tmp.downRight) {	// These should both be zero if no block is there
					this.y += this.dy;
					Game.main.spriteContainer.mapLayer.y -= this.dy;
				} else {
					this.y = (Math.floor(this.y / Block.size) + 1) * Block.size - this.height / 2;
					this.dy = this.ddy = 0;
					collisionSound.play();
				}
			}
			
			// Move in X direction
			tmp = checkCollision(this.x + this.dx, this.y);
			if(this.dx < 0) {
				if(!tmp.downLeft && !tmp.upLeft) {	// These should both be zero if no block is there
					this.x += this.dx;
					Game.main.spriteContainer.mapLayer.x -= this.dx;
				} else {
					this.x = Math.floor(this.x / Block.size) * Block.size + this.width / 2;
					this.dx = this.ddy = 0;
					collisionSound.play();
				}
			} else if(this.dx > 0) {
				if(!tmp.downRight && !tmp.upRight) {	// These should both be zero if no block is there
					this.x += this.dx;
					Game.main.spriteContainer.mapLayer.x -= this.dx;
				} else {
					this.x = (Math.floor(this.x / Block.size) + 1) * Block.size - this.width / 2;
					this.dx = this.ddy = 0;
					collisionSound.play();
				}
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

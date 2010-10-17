package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;

	public class Ball extends Sprite {
		
		// Public
		public var dx:Number = 0, dy:Number = 0, ddx:Number = 0, ddy:Number = 0;
		
		public var friction:Number = 0.95;
		
		[Embed(source="graphics/ballv2.svg")]
		private var BallGraphic:Class;
		public var spriteContainer:Sprite;
		
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
		
		private function checkCollision(newXPosition:Number, newYPosition:Number):Object {
			var corners:Object = new Object();
			
			corners.downY = Math.floor((newYPosition + this.height / 2 - 1) / Block.size);
			corners.upY = Math.floor((newYPosition - this.height / 2) / Block.size);
			corners.leftX = Math.floor((newXPosition - this.width / 2) / Block.size);
			corners.rightX = Math.floor((newXPosition + this.width / 2 - 1) / Block.size);

			corners.upLeft = Game.main.mapData[Game.main.currentLevel][corners.upY][corners.leftX];
			corners.downLeft = Game.main.mapData[Game.main.currentLevel][corners.downY][corners.leftX];
			corners.upRight = Game.main.mapData[Game.main.currentLevel][corners.upY][corners.rightX];
			corners.downRight = Game.main.mapData[Game.main.currentLevel][corners.downY][corners.rightX];

			return corners;
		}
		
		// Apply movement
		private function doMovement():void {
			var difference:Number;
			
			// Add acceleration to current speed
			this.dx += this.ddx;
			this.dy += this.ddy;
			
			// Move in Y direction
			var tmp:Object = checkCollision(this.x/* - Game.main.mapLayer.x*/, this.y + this.dy/* - Game.main.mapLayer.y*/);
			if(this.dy < 0) {
				if(!tmp.upLeft && !tmp.upRight) {	// These should both be zero if no block is there
					this.y += this.dy;
					//Game.main.mapLayer.y -= this.dy;	// Move map in opposite direction
				} else {
					difference = this.y - (Math.floor(this.y / Block.size) * Block.size + this.height / 2);
					this.y -= difference;
					//Game.main.mapLayer.y -= difference;
					this.dy = -this.dy / 2;
					this.ddy = 0;
					collisionSound.play();
				}
			} else if(this.dy > 0) {
				if(!tmp.downLeft && !tmp.downRight) {	// These should both be zero if no block is there
					this.y += this.dy;
					//Game.main.mapLayer.y -= this.dy;	// Move map in opposite direction
				} else {
					difference = this.y - (Math.floor(this.y / Block.size) * Block.size + this.height / 2);
					this.y -= difference;
					//Game.main.mapLayer.y += difference;
					this.dy = -this.dy / 2;
					this.ddy = 0;
					collisionSound.play();
				}
			}
			
			// Move in X direction
			tmp = checkCollision(this.x + this.dx/* - Game.main.mapLayer.x*/, this.y/* - Game.main.mapLayer.y*/);
			if(this.dx < 0) {
				if(!tmp.downLeft && !tmp.upLeft) {	// These should both be zero if no block is there
					this.x += this.dx;
					//Game.main.mapLayer.x -= this.dx;	// Move map in opposite direction
				} else {
					difference = this.x - (Math.floor(this.x / Block.size) * Block.size + this.width / 2);
					this.x -= difference;
					//Game.main.mapLayer.x += difference;
					this.dx = -this.dx / 2;
					this.ddx = 0;
					collisionSound.play();
				}
			} else if(this.dx > 0) {
				if(!tmp.downRight && !tmp.upRight) {	// These should both be zero if no block is there
					this.x += this.dx;
					//Game.main.mapLayer.x -= this.dx;	// Move map in opposite direction
				} else {
					difference = this.x - (Math.floor(this.x / Block.size) * Block.size + this.width / 2);
					this.x -= difference;
					//Game.main.mapLayer.x += difference;
					this.dx = -this.dx / 2;
					this.ddx = 0;
					collisionSound.play();
				}
			}
			
			// Determine how friction affects speed
			this.dx = (this.dx <= 0.05 && this.dx >= -0.05) ? 0 : this.dx * this.friction;
			this.dy = (this.dy <= 0.05 && this.dy >= -0.05) ? 0 : this.dy * this.friction;
		}
		
		
		public function getDistanceFrom(_x:Number, _y:Number):Number {
			return Math.sqrt((this.x - _x) * (this.x - _x) + (this.y - _y) * (this.y - _y));
		}
	}
}

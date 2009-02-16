package {
	
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.media.Sound;
	
	public class Collectable extends Sprite {
		
		private var spriteContainer:Sprite;
		[Embed(source="sounds/pickup.mp3")]
		private var PickupSoundEffect:Class;
		
		public function Collectable(_x:int, _y:int):void {
			this.x = _x;
			this.y = _y;
		
			spriteContainer = new Sprite();
			spriteContainer.graphics.beginFill(0x0000ff);
			spriteContainer.graphics.drawCircle(0, 10, 10);
			spriteContainer.graphics.endFill();
			this.addChild(spriteContainer);
			
			// Add to main display object container
			Game.main.spriteContainer.addChild(this);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			// Check for collision with ball
			if(this.hitTestObject(Game.main.ball)) {
				// Play Sound
				var s:Sound = new PickupSoundEffect() as Sound;
				s.play();
				
				// Destroy collectable
				this.destroy();
				
				// Increase size ov ball
				Game.main.ball.width *= 1.2;
				Game.main.ball.height *= 1.2;
			}
		}
		
		public function destroy():void {
			// Remove this object
			if(Game.main.spriteContainer.contains(this))
				Game.main.spriteContainer.removeChild(this);
			
			// Also remove event listener!
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}
package {
	import flash.display.Sprite

	public class Ball extends Sprite {
		
		[Embed(source="graphics/ball.svg")]
		private var BallGraphic:Class;
		
		private var spriteContainer:Sprite;
		
		public function Ball():void {
			var s:Sprite = new BallGraphic();
			
			spriteContainer = new Sprite();
			spriteContainer.addChild(s);
			
			// Center contents
			spriteContainer.x = -spriteContainer.width/2;
			spriteContainer.y = -spriteContainer.height/2;
			
			// Add to display list
			this.addChild(spriteContainer);
		}
	}
}
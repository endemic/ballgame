package {
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.*;
	
	public class FadeText extends Sprite {

		public function FadeText(s:String, x_:int, y_:int):void {
			this.x = x_;
			this.y = y_;
			
			var message:TextField = new TextField();
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 14;
			
			message.textColor = 0xff00ff;
			message.autoSize = TextFieldAutoSize.LEFT;		// Automatically resizes the text field with center justification
			message.defaultTextFormat = myFormat;
			message.text = s;
			this.addChild(message);
			
			Game.main.spriteContainer.addChild(this);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void {
			// Fade the text
			this.alpha -= 0.1;
			
			// Move text upwards
			this.y -= 1;
			
			// If invisible, remove from display object container
			if(this.alpha <= 0)
				this.remove();
		}
		
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			Game.main.spriteContainer.removeChild(this);
		}
	}
}
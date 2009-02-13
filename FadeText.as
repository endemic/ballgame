package {

	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	
	public class FadeText extends Sprite {

		public function FadeText(m:String, x_:int, y_:int):void {
			x = x_;
			y = y_;
			
			var message:TextField = new TextField();
			
			var myFormat:TextFormat = new TextFormat();
			var myFont:Font = new Museo();
			myFormat.font = myFont.fontName;
			myFormat.size = 14;
			
			message.textColor = 0xffffff;
			message.autoSize = TextFieldAutoSize.LEFT;		// Automatically resizes the text field with center justification
			message.defaultTextFormat = myFormat;
			message.embedFonts = true;
			message.text = m;
			
			addChild(message);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void {
			// Fade the text
			alpha -= 0.1;
			
			// Move text upwards
			y -= 1;
			
			// Make text slightly bigger
			//scaleX += 0.1;
			//scaleY += 0.1;
			
			// If invisible, remove from display object container
			if(alpha <= 0)
				remove();
		}
		
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			Game.main.removeChild(this);
		}
	}
}
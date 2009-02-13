package {
	import flash.display.Sprite;
	import flash.text.*;
	
	public class DebugText extends Sprite {
		
		public var message:TextField;
		
		public function DebugText(s:String, _x:int, _y:int):void {
			this.x = _x;
			this.y = _y;
			
			var myFormat:TextFormat = new TextFormat();
			myFormat.size = 14;
			
			message = new TextField();
			message.textColor = 0xff0000;
			message.autoSize = TextFieldAutoSize.LEFT;		// Automatically resizes the text field with center justification
			message.defaultTextFormat = myFormat;
			message.text = s;
			this.addChild(message);
			Game.main.spriteContainer.addChild(this);
		}
	}
}
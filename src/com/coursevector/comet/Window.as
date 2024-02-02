package com.coursevector.comet {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import com.coursevector.comet.Comet;
	import flash.text.TextFormat;
	
	public class Window extends flash.display.MovieClip {
		
		protected var window:Sprite;
		
		protected var titleBar:Sprite;
		protected var myParent:Comet;
		private var windowID:int;
		private var windowX:int;
		private var windowY:int;
		private var windowW:int;
		private var windowH:int;
		protected var tfTitle:TextFormat;
		protected var tfText:TextFormat;
		private static const DISPLAY_WINDOW:String = "display_window";
		
		public function Window(parent:Comet, idNum:int, x:int, y:int, w:int, h:int) {
			//trace("Window.Window(parent="+parent+", idNum:int="+idNum+", x:int="+x+", y:int="+y+", w:int="+w+", h:int="+h+")");
			myParent = parent;
			windowID = idNum;
			windowX = x;
			windowY = y;
			windowW = w;
			windowH = h;
			
			tfTitle = new TextFormat();
			tfTitle.font = "Tw Cen MT";
			tfTitle.size = 12;
			tfTitle.bold = true;
			tfTitle.color = 0xffffff;
			
			tfText = new TextFormat();
			tfText.font = "Tw Cen MT";
			tfText.size = 13;
			tfText.bold = false;
			tfText.color = 0xffffff;
			
			init(DISPLAY_WINDOW);
		}
		
		public function center():void {
			window.x = (myParent.width - window.width) / 2;
		}
		
		private function init(command:String):void {
			switch(command)	{
				case "display_window":
					displayWindow();
					break;
			}
		}
		
		private function displayWindow():void {
			//Window Background
			window = new Sprite();
			window.graphics.lineStyle(1, 0x343434, 1);
			window.graphics.beginFill(0x121212, 1);
			window.graphics.drawRoundRect(0 , 0, windowW, windowH, 5, 5);
			window.graphics.endFill();
			window.x = windowX;
			window.y = windowY;
			myParent.addChild(window);
			
			//Title Bar
			titleBar = new Sprite();
			titleBar.graphics.beginFill(0x333333, 1.0);
			titleBar.graphics.drawRoundRect(0 , 0, window.width, 20, 0, 0);
			titleBar.graphics.endFill();
			titleBar.x = 0;
			titleBar.y = 0;
			titleBar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			titleBar.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			window.addChild(titleBar);
			
			//Send Button Text
			var versionLabel:TextField = new TextField();
            versionLabel.selectable = false;
			versionLabel.width = titleBar.width;
            versionLabel.text = "Comet  -  Version " + Comet.VERSION;
			versionLabel.setTextFormat(tfTitle);
			versionLabel.x = 2;
			versionLabel.y = 0;
			titleBar.addChild(versionLabel);
		}
		
		private function mouseDown(event:MouseEvent):void {
			window.startDrag();
		}
		
		private function mouseUp(event:MouseEvent):void {
			window.stopDrag();
		}
	}
}
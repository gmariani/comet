package com.coursevector.comet {

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import fl.controls.Button;
	import com.coursevector.comet.Comet;
	
	public class LoginWindow extends Window {
		
		private var inputPassword:TextField;
		private var sendButton:Sprite;
		private var userChoiceButtons:Button;
		private static const DISPLAY_LOGIN:String = "display_login";
		
		public function LoginWindow(parent:Comet, idNum:int, x:int, y:int, w:int, h:int) {
			//trace("LoginWindow.LoginWindow(parent=" + parent + ", idNum:int=" + idNum + ", x:int=" + x + ", y:int=" + y + ", w:int=" + w + ", h:int=" + h + ")");
			super(parent, idNum, x, y, w, h);
			myParent = parent;
			init(DISPLAY_LOGIN);
		}

		private function init(command:String):void {
			switch(command)	{
				case "display_login":
					displayLogin();
					break;
			}
		}
		
		private function displayLogin():void {
			userChoiceButtons = new Button();
			userChoiceButtons.label = "Login";
			userChoiceButtons.y = (window.height - userChoiceButtons.height) / 2;
			userChoiceButtons.x = (window.width - userChoiceButtons.width) / 2;
			userChoiceButtons.addEventListener(MouseEvent.MOUSE_DOWN, doLogin);
			window.addChild(userChoiceButtons);
		}
		
		private function doLogin(e:Event):void {
			//trace("Talk.chooseJames(e:Event="+e+")");
			myParent.removeChild(window);
			myParent.userID = 1;
			myParent.init("refreshStart");
		}
	}
}
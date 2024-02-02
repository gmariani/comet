package com.coursevector.comet {
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
    import flash.net.navigateToURL;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.IOErrorEvent;
	import flash.text.TextField;
	import flash.media.Sound;

	public class Comet extends MovieClip {
		public static const TESTING:String = "";
		//public var TESTING:String = "TEST";
		public static const LOAD:String = "load";
		public static const REFRESH_START:String = "refreshStart";
		public static const LOGIN:String = "login";
		public static const VERSION:String = "0.6";
		public var HISTORY_LOCATION:String = urlPath + "history" + TESTING + ".php";
		public var INSERT_LOCATION:String = urlPath + "insert" + TESTING + ".php";
		public var CLEAR_LOCATION:String = urlPath + "clear" + TESTING + ".php";
		public var userID:int = 1;
		public var lastID:int = 0;
		
		private var urlPath:String = "http://mariani.life/projects/comet/";
		private var history;
		private var refreshTimer:Timer = new Timer(5000);
		private var messageCount:int;
		private var windows:Array = [];
		private var chatWindowID:int;
		
		public function Comet() {
			init(LOGIN);
		}
		
		public function init(command:String):void {
			//trace("Comet.init(command:String="+command+")");
			switch(command)	{
				case "login":
					windows.push(new LoginWindow(this, 0, 5, 5, 150, 150));
					windows[windows.length-1].center();
					break;
				case "refreshStart":
					windows.push(new ChatWindow(this, 1, 5, 5, 500, 400));
					chatWindowID = windows.length - 1;
					//trace("chatWindowID"+chatWindowID);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
					refreshTimer.addEventListener("timer", refresh);
					refreshTimer.start();
					break;
				case "load":
					loadData("XML");
					break;
			}
		}
		
		private function reportKeyDown(event:KeyboardEvent):void {
			switch(event.charCode) {
				case 13:
					sendText(chatWindowID);
			}
        }
		
		private function refresh(e:Event):void {
			//trace("Comet.refresh(e:Event="+e+")");
			init(LOAD);
		}
		
		//Called from init
		private function loadData(option:String):void {
			var myDate1:Date = new Date();
			//trace("Comet.loadData(option:String="+option+")");
			if(option == "XML") {
				//Load XML History File
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, loadXML);
				//loader.load(new URLRequest("http://labs.coursevector.com/projects/comet/history.php?lastID="+lastID));
				loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				loader.load(new URLRequest(HISTORY_LOCATION+"?lastID="+lastID+"&time="+myDate1.getTime()));
			}
		}
		
		//Called from loadData
		private function loadXML(e:Event):void {
			//trace("Comet.loadXML(e:Event="+e+")");
			if(e.target.data == "login") {
				//trace("@@@@@@@Going to Login");
				var loader:URLLoader = new URLLoader();
				navigateToURL(new URLRequest("http://mariani.life/projects/comet/blackbox.php?lastpage=http://mariani.life/projects/comet/"), '_self');
				
				return;
			}
			
			if(e.target.data != "0") {
				history = new XML(e.target.data);
				if (history.children()[history.children().length()-1].attribute("id") > lastID) {
					//trace("lastID: "+lastID);
					lastID = history.children()[history.children().length()-1].attribute("id");
					windows[chatWindowID].loadData(history);
					playSound("message");
				}
			}
		}
		
		private function onIOError(e:Event):void {
			trace("onIOError:" + e);
		}
		
		private function playSound(s:String):void {
			switch(s) {
				case "message":
					//Play new message sound
					var snd:Sound = new Sound();
					snd.load(new URLRequest("message.mp3"));
					snd.play();
					break;
			}
		}
		
		private function sendText(id:int):void {
			windows[id].send();
		}
	}
}
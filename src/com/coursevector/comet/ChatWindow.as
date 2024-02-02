package com.coursevector.comet {
	
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.text.TextField;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import MultiLineCell;
	import com.coursevector.comet.Comet;
	
	public class ChatWindow extends Window {
		
		private var inputText:TextField;
		private var sendButton:Button;
		private var clearButton:Sprite;
		private var aDg:DataGrid;
		private var chatData:XML;
		private var INSERT_LOCATION:String;
		private var CLEAR_LOCATION:String;
		private static const DISPLAY_DATA:String = "display_data";
		private var spacing:int = 5;
		
		public function ChatWindow(parent:Comet, idNum:int, x:int, y:int, w:int, h:int) {
			//trace("ChatWindow.ChatWindow(parent=" + parent + ", idNum:int=" + idNum + ", x:int=" + x + ", y:int=" + y + ", w:int=" + w + ", h:int=" + h + ")");
			super(parent, idNum, x, y, w, h);
			myParent = parent;
			INSERT_LOCATION = myParent.INSERT_LOCATION;
			CLEAR_LOCATION = myParent.CLEAR_LOCATION;
			init(DISPLAY_DATA);
		}
		
		public function getInputText():String {
			var tmp:String = inputText.text;
			inputText.text = "";
			return tmp;
		}
		
		public function loadData(data:XML):void {
			//trace("ChatWindow.loadData(data:XML="+data+")");
			chatData = data;
			if(aDg)	{
				//trace("Length: "+chatData.children().length());
				for (var i = 0; i < chatData.children().length(); i++) {
				var o:Object = new Object();
					o.time = String(chatData.children()[i].attribute("time"));
					o.name = String(chatData.children()[i].attribute("name"));
					o.text = String(chatData.children()[i]);
					aDg.addItem(o);
					//trace(o.text.length+"adding:" + o.text);
					if (o.text.length > 60 && aDg.rowHeight < 36) aDg.rowHeight = 36;
					if (o.text.length > 120 && aDg.rowHeight < 54) aDg.rowHeight = 54;
					if (o.text.length > 180 && aDg.rowHeight < 72) aDg.rowHeight = 72;
				}
				aDg.scrollToIndex(aDg.rowCount * aDg.rowHeight);
			}
		}
		
		public function send():void	{
			//trace("ChatWindow.send() - " + inputText.text);
			//var request:URLRequest = new URLRequest("http://labs.coursevector.com/talk/insert.php?id=1&text="+getInputText());
			var request:URLRequest = new URLRequest(INSERT_LOCATION+"?id="+myParent.userID+"&text="+getInputText());
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}
		
		private function init(command:String):void {
			switch(command) {
				case "display_data":
					displayDataGrid();
					break;
			}
		}
		
		private function displayDataGrid():void {
			//trace("ChatWindow.displayDataGrid()");
			//Connect XML to Datagrid columns
			var timeCol:DataGridColumn = new DataGridColumn("time");
			timeCol.headerText = "Time";
			timeCol.width = 90;
			timeCol.cellRenderer = MultiLineCell;
			var nameCol:DataGridColumn = new DataGridColumn("name");
			nameCol.headerText = "Name";
			nameCol.width = 50;
			nameCol.cellRenderer = MultiLineCell;
			var textCol:DataGridColumn = new DataGridColumn("text");
			textCol.headerText = "Text";
			textCol.width = 360;
			textCol.cellRenderer = MultiLineCell;
	
			//Create Datagrid with columns
			if (aDg) {
				//trace("remove");
				removeChild(aDg);
				aDg = null;
			}
			
			//Create input text box
			inputText = new TextField();
			inputText.width = 450;
			inputText.text = "Type Here";
			inputText.setTextFormat(tfText);
			inputText.type = "input";
			inputText.selectable = true;
			inputText.x = spacing;
			inputText.y = window.height - inputText.textHeight - 13;
			//stage.focus = inputText;
			
			//Send Button Background
			sendButton = new Button();
			sendButton.label = "SEND";
			sendButton.width = 50;
			/*sendButton = new Sprite();
            sendButton.graphics.clear();
            sendButton.graphics.beginFill(0x2222DD, 0.60);
            sendButton.graphics.drawRoundRect(0, 0, 40, square.height, 10, 10);
			
            sendButton.graphics.endFill();*/
			sendButton.x = window.width - sendButton.width - 10;
			sendButton.y = inputText.y;
			inputText.width = window.width - (inputText.x + sendButton.width + 10) - spacing;
			window.addChild(sendButton);
			
			//trace("add");
			aDg = new DataGrid();
			aDg.headerHeight = 0;
			
			window.addChild(aDg);
			var myDP:DataProvider = new DataProvider(chatData);
			aDg.columns = [timeCol, nameCol, textCol];
			aDg.dataProvider = myDP;
			aDg.rowCount = aDg.length;
			aDg.x = spacing;
			aDg.y = 25;
			aDg.width = 490;
			aDg.height = 340;// window.height - aDg.y - (inputText.textHeight + (spacing * 2));
			aDg.scrollToIndex(aDg.rowCount*aDg.rowHeight);
			
			// Input Text Box Background
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xffffff, 0.10);
			square.graphics.drawRect(inputText.x , inputText.y, inputText.width, inputText.textHeight * 1.5);
			square.graphics.endFill();
			window.addChild(square);
			window.addChild(inputText);
			
			
			
			//Send Button Text
			/*var textLabel:TextField = new TextField();
            textLabel.selectable = false;
            textLabel.text = "SEND";
			textLabel.x = 3;
			textLabel.y = 2;
			textLabel.height = sendButton.height;
			sendButton.addChild(textLabel);*/
			
			sendButton.addEventListener(MouseEvent.MOUSE_DOWN, sendOnDownHandler);
			
			/*
			 * Removed till everything else is working
			 *
			//Clear Button Background
			clearButton = new Sprite();
            clearButton.graphics.clear();
            clearButton.graphics.beginFill(0x2222DD, 0.60);
            clearButton.graphics.drawRoundRect(0, 0, 40, square.height, 10, 10);
			clearButton.x = inputText.x + inputText.width + 10;
			clearButton.y = inputText.y+30;
            clearButton.graphics.endFill();
			window.addChild(clearButton);
			
			//Clear Button Text
			var clearTextLabel:TextField = new TextField();
            clearTextLabel.selectable = false;
            clearTextLabel.text = "Clear";
			clearTextLabel.x = 3;
			clearTextLabel.y = 2;
			clearTextLabel.height = clearButton.height;
			clearButton.addChild(clearTextLabel);
			
			clearButton.addEventListener(MouseEvent.MOUSE_DOWN, clear);
			*/
		}

		private function sendOnDownHandler(e:Event):void {
			send();
		}
		
		private function onIOError(e:Event):void {
			trace("onIOError:" + e);
		}
		
		private function clear(e:Event):void {
			//var request:URLRequest = new URLRequest("http://labs.coursevector.com/talk/clear.php");
			var request:URLRequest = new URLRequest(CLEAR_LOCATION);
			var loader:URLLoader = new URLLoader();
			loader.load(request);
			//myParent.lastTime = "";
		}
	}
}
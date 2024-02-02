package
{
	import flash.display.Sprite;
	import flash.text.TextField;
    import fl.controls.listClasses.ICellRenderer;
    import fl.controls.listClasses.ListData;
	import flash.text.TextFormat;
    
    public class MultiLineCell extends Sprite implements ICellRenderer {
        private var _listData:ListData;
        private var _data:Object;
        private var _selected:Boolean;
        private var _mouseState:String;
		private var text:TextField;
		public var setStyle;
		private var tfText:TextFormat;
        
        public function MultiLineCell() {
			tfText = new TextFormat();
			tfText.font = "Tw Cen MT";
			tfText.size = 13;
			tfText.bold = false;
			tfText.color = 0xffffff;
			
			text = new TextField();
			text.type = "input";
			text.selectable = true;	
			text.multiline = true;
			text.wordWrap = true;
			this.addChild(text);
        }

        public function set listData(newListData:ListData):void {
            _listData = newListData;
            text.text = _listData.label;
			text.setTextFormat(tfText);
			width = width;
			text.width = width;
			text.height = height;
        }

        public function get listData():ListData {
            return _listData;
        }

        public function set data(newData:Object):void {
            _data = newData;
        }

        public function get data():Object {
            return _data;
        }

        public function setSize(w:Number,h:Number):void {
			width = w;
			height = h;
        }

        public function set selected(value:Boolean):void {
            _selected = value;
        }

        public function get selected():Boolean {
            return _selected;
        }
		
		public function setMouseState(state:String):void {
			_mouseState = state;
		}
    }
}
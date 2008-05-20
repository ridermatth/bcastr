package com.ruochi.bcastr{
	import com.ruochi.events.Eventer;
	import com.ruochi.shape.Rect;
	import com.ruochi.text.StyleText;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.TweenLite;
	public class Title extends Sprite implements IBcastrPlugIn {
		private var _styleText:StyleText = new StyleText();
		private var _bgHeight:Number = 24;
		private var _bgWidth:Number;
		private var _bgColor:uint = 0xff9900;
		private var _bgAlpha:Number = .5;
		private var _bg:Rect;
		private var _text:String;
		private var _tweenDuration:Number = 1;
		public function Title(w:Number, h:Number =24) {
			_bgHeight = h;
			_bgWidth = w;
			this.addEventListener(Event.ADDED_TO_STAGE, onStage, false, 0, true);
		}
		public function resieveJavaScript(ob:Object):void {
			_styleText.text = ob.toString();
		}
		private function onStage(e:Event) {
			buildUI()
		}
		private function buildUI() {
			_bg = new Rect(_bgWidth, _bgHeight, _bgColor);
			_bg.alpha = _bgAlpha;
			_styleText.width = _bgWidth;
			_styleText.align = "center";
			_styleText.autoSize = "center";
			addChild(_bg);
			addChild(_styleText);
		}
		public function set titleText(str:String) {
			_text = str;
			_styleText.text = _text;
			y = -height;
			TweenLite.to(this, _tweenDuration, { y:0 } );
		}
		public function recieveEventer(event:Object):void {
			if(event.type=="change"){
				titleText = event.xml.title[0];
			}
		}
	}
}
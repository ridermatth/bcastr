package com.ruochi.bcastr{
	import com.ruochi.events.Eventer;
	import com.ruochi.shape.Rect;
	import com.ruochi.text.StyleText;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.TweenLite;
	import com.ruochi.bcastr.BcastrConfig;
	public class Title extends Sprite {
		private var _styleText:StyleText = new StyleText();
		private var _bgHeight:Number = 24;
		private var _bgWidth:Number;
		private var _bg:Rect;
		private var _text:String;
		static private var _instance:Title = new Title();
		public function Title() {
			if (!_instance) {
				
			}else {
				throw new Error("singleton");
			}
			
		}
		public function init(w:Number, h:Number = 24):void {
			_bgHeight = h;
			_bgWidth = w;
			buildUI();
		}
		
		private function onBcastr4Change(e:Eventer):void {
			titleText = BcastrConfig.dataXml.channel.item[e.eventInfo].title;
		}
		private function buildUI():void {
			_bg = new Rect(_bgWidth, _bgHeight, BcastrConfig.titleBgColor);
			_bg.alpha = BcastrConfig.titleBgAlpha;
			_styleText.width = _bgWidth;
			_styleText.align = "center";
			_styleText.autoSize = "center";
			_styleText.color = BcastrConfig.titleTextColor;
			_styleText.font = BcastrConfig.titleFont
			y = -_bgHeight;
			addChild(_bg);
			addChild(_styleText);
		}
		private function showTitle():void {
			_styleText.text = _text;
			if (_text && _text.length > 0) {
				TweenLite.to(this, BcastrConfig.titleMoveDuration / 2, { y:0 } );
			}
		}
		public function set titleText(str:String):void {
			_text = str;
			TweenLite.to(this, BcastrConfig.titleMoveDuration / 2, { y: -height, onComplete:showTitle } );
		}
				
		static public function get instance():Title { return _instance; }
	}
}
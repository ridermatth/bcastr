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
		private var _height:Number = 24;
		private var _width:Number;
		private var _bg:Rect = new Rect();
		private var _text:String;
		static private var _instance:Title = new Title();
		public function Title() {
			if (!_instance) {
				
			}else {
				throw new Error("singleton");
			}			
		}
		public function init():void {
			setChildren();
		}
		
		override public function get width():Number { return _width; }
		
		override public function set width(value:Number):void {
			_width = value;
			_bg.width = _width;
			_styleText.width = _width;
			_styleText.x = 0;
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void {
			_height = value;
			_bg.height = value;
		}
		
		
		private function onBcastr4Change(e:Eventer):void {
			titleText = BcastrConfig.dataXml.channel.item[e.eventInfo].title;
		}
		private function setChildren():void {
			_styleText.align = "center";
			_styleText.autoSize = "none";
			_styleText.height = 20;
			y = -_height;
			addChild(_bg);
			addChild(_styleText);
			width = _width;
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
		
		public function get styleText():StyleText { return _styleText; }
		
		public function get bg():Rect { return _bg; }
		
		public function set bg(value:Rect):void {
			_bg = value;
		}
	}
}
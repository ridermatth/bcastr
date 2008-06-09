package com.ruochi.shape{
	import flash.display.Sprite;
	public class Rect extends Sprite {
		private var _color:uint = 0xffffff;
		private var _w:Number;
		private var _h:Number;
		public function Rect(w:Number=100,h:Number=100,c:uint=0xffffff) {
			super();
			_color = c;
			_w = w;
			_h = h;
			buildUI()
		}
		private function buildUI():void {
			graphics.clear()
			graphics.beginFill(_color);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
		}
		public function set color(c:uint):void {
			_color = c;
			buildUI()
		}
		public function get color():uint {
			return _color;
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void {
			_w = value
			buildUI();
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void {
			_h = value;
			buildUI();
		}
	}
}
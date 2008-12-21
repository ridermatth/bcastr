package com.ruochi.geom{
	public class Color {
		private var _color:uint;
		private var _r:uint;
		private var _g:uint;
		private var _b:uint;
		public function Color(c:uint=0) {
			color = c;
		}
		public function get color():uint{
			return _color
		}
		public function get red():uint{
			return _r
		}
		public function get green():uint{
			return _g
		}
		public function get blue():uint{
			return _b
		}
		public function set red(r:uint):void {
			_r = r;
			_color = _r * 65536 + _g * 256 + _b; 
		}
		public function set green(g:uint):void {
			_g = g;
			_color = _r * 65536 + _g * 256 + _b; 
		}
		public function set blue(b:uint):void {
			_b = b;
			_color = _r * 65536 + _g * 256 + _b; 
		}
		public function set color(c:uint):void{
			_color = c;
			_r = Math.floor(_color / 65536);
			_g = Math.floor((_color % 65536) / 256);
			_b = _color % 256;
		}
	}
}
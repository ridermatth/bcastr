package com.ruochi.component{
	import com.ruochi.shape.GradientRadialTopLeftRect;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ruochi.text.EmbedText;
	import gs.TweenLite;
	public class GradientRadialBtn extends Sprite {
		private var _btnWidth:Number =16;
		private var _btnHeight:Number = 16;
		private var _color:uint = 0xff6600;
		private var _hoverColor:uint = 0xff9900;
		private var _defaultColor:uint = 0x1B3433;
		private var _focusColor:uint = 0xff6600;
		private var _isFocus:Boolean = false;
		private var _body:GradientRadialTopLeftRect = new GradientRadialTopLeftRect(_btnWidth, _btnHeight, _color, _color, .5, .8);
		private var _numText:EmbedText = new EmbedText();
		public function GradientRadialBtn() {
			init();
		}
		private function init():void {
			buildUI();
			addListener()
		}
		private function buildUI():void {
			_numText.mouseEnabled = false;
			color = _defaultColor;
			buttonMode = true;
			_numText.font = "SG16"
			_numText.y = 2;			
			_numText.align = "center"
			_numText.autoSize = "center";			
			_numText.width = _btnWidth;
			_numText.size = 10;
			addChild(_body);
			addChild(_numText);
		}
		private function addListener():void {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
		}
		private function onMouseOver(e:MouseEvent):void {
			color = _hoverColor;
		}
		private function onMouseOut(e:MouseEvent):void {
			if (_isFocus) {
				color = _focusColor;
			}else {
				color = _defaultColor;
			}
		}
		public function set color(col:Number) {
			_color = col;
			TweenLite.to(_body, .5, { tint:_color } );
		}
		public function set isFocus(boo:Boolean) {
			_isFocus = boo;
			if (_isFocus) {
				color = _focusColor;
			}else {
				color = _defaultColor;
			}			
		}
		public function set text(str:String):void {
			_numText.text = str;
		}
	}
}
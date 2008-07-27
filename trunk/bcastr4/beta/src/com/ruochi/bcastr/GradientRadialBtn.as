package com.ruochi.bcastr{
	import com.ruochi.shape.GradientRadialTopLeftRect;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ruochi.text.EmbedText;
	import gs.TweenLite;
	import com.ruochi.bcastr.BcastrConfig;
	public class GradientRadialBtn extends Sprite {
		private var _isFocus:Boolean = false;
		private var _color:uint;
		private var _body:GradientRadialTopLeftRect = new GradientRadialTopLeftRect(BcastrConfig.btnWidth, BcastrConfig.btnHeight, BcastrConfig.btnDefaultColor, BcastrConfig.btnDefaultColor, BcastrConfig.btnAlpha, BcastrConfig.btnAlpha*1.2);
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
			color = BcastrConfig.btnDefaultColor;
			buttonMode = true;
			_numText.font = "SG16"
			_numText.align = "center"
			_numText.autoSize = "center";
			_numText.y = 2;
			_numText.x = 0;
			_numText.color = BcastrConfig.btnTextColor;
			addChild(_body);
			addChild(_numText);						
			_numText.width = BcastrConfig.btnWidth;
			_numText.size = BcastrConfig.btnFontSize;
			cacheAsBitmap = true;
		}
		private function addListener():void {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
		}
		private function onMouseOver(e:MouseEvent):void {
			color = BcastrConfig.btnHoverColor;
		}
		private function onMouseOut(e:MouseEvent):void {
			if (_isFocus) {
				color = BcastrConfig.btnFocusColor;
			}else {
				color = BcastrConfig.btnDefaultColor;
			}
		}
		public function set color(col:Number):void {
			_color = col;
			TweenLite.to(_body, .5, { tint:_color } );
		}
		public function set isFocus(boo:Boolean):void {
			_isFocus = boo;
			if (_isFocus) {
				color = BcastrConfig.btnFocusColor;
			}else {
				color = BcastrConfig.btnDefaultColor;
			}			
		}
		public function set text(str:String):void {
			_numText.text = str;
		}
	}
}
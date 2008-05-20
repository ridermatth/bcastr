package com.ruochi.bcastr {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.ruochi.component.GradientRadialBtn;
	import com.ruochi.bcastr.Bcastr4;
	public class BtnSet extends Sprite implements IBcastrPlugIn {
		private var _length:int;
		private var _focusId:int = 0;
		private var _distance:Number = 20;
		private var _paddingBottom = 5;
		private var _paddingRight = 5;
		private var _bcastr4:Bcastr4;
		public function BtnSet() {
			
		}
		private function init():void {
			_bcastr4 = parent as Bcastr4;
			_length = _bcastr4.numImage;
			buildUI();
		}
		private function onBtnClick(e:MouseEvent):void {
			(parent as Bcastr4).goto(getChildIndex(e.currentTarget as DisplayObject));
		}
		private function buildUI():void {
			for (var i:int = 0; i < _length; i++) {
				var btn:GradientRadialBtn = new GradientRadialBtn();
				btn.x = _distance * i;
				btn.text = String(i + 1);
				btn.addEventListener(MouseEvent.CLICK, onBtnClick, false, 0, true);
				addChild(btn);
			}
			x = _bcastr4.imageContainer.imageWidth - width -_paddingRight;
			y = _bcastr4.imageContainer.imageHeight - height -_paddingBottom;
		}
		public function set focusId(num:int):void {
			(getChildAt(_focusId) as GradientRadialBtn).isFocus = false;
			_focusId = num;
			(getChildAt(_focusId) as GradientRadialBtn).isFocus = true;
		}
		public function recieveEventer(event:Object):void {
			switch(event.type) {
				case "init":
				init();
				break;
				case "change":
				focusId = int(event.id);
				break;
			}
		}
	}
}
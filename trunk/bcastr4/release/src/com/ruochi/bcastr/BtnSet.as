package com.ruochi.bcastr {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.ruochi.bcastr.GradientRadialBtn;
	import com.ruochi.bcastr.Bcastr4;
	import com.ruochi.events.Eventer;
	public class BtnSet extends Sprite {
		private var _length:int;
		private var _focusId:int = 0;
		private var _bcastr4:Bcastr4;
		public function BtnSet() {
			
		}
		public function init():void {
			_bcastr4 = Bcastr4.instance;
			_length = _bcastr4.numImage;
			buildUI();
			_bcastr4.addEventListener(Eventer.CHANGE, onBcastr4Change, false, 0, true);
		}
		
		private function onBcastr4Change(e:Eventer):void {
			focusId = int(e.eventInfo);
		}
		private function onBtnClick(e:MouseEvent):void {			
			_bcastr4.goto(getChildIndex(e.currentTarget as DisplayObject));
		}
		private function onBtnMouseOver(e:MouseEvent):void {
			_bcastr4.goto(getChildIndex(e.currentTarget as DisplayObject));
		}
		private function buildUI():void {
			for (var i:int = 0; i < _length; i++) {
				var btn:GradientRadialBtn = new GradientRadialBtn();
				btn.x = BcastrConfig.btnDistance * i;
				btn.text = String(i + 1);
				if(BcastrConfig.changImageMode == BcastrConfig.CLICK){
					btn.addEventListener(MouseEvent.CLICK, onBtnClick, false, 0, true);
				}else {
					btn.addEventListener(MouseEvent.MOUSE_OVER, onBtnMouseOver, false, 0, true);
				}
				addChild(btn);
			}
		}
		
		public function set focusId(num:int):void {
			(getChildAt(_focusId) as GradientRadialBtn).isFocus = false;
			_focusId = num;
			(getChildAt(_focusId) as GradientRadialBtn).isFocus = true;
		}
	}
}
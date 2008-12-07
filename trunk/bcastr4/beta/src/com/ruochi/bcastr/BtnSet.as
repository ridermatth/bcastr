package com.ruochi.bcastr {
	import com.ruochi.component.AutoScroll;
	import com.ruochi.shape.Rect;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.ruochi.bcastr.GradientRadialBtn;
	import com.ruochi.events.Eventer;
	public class BtnSet extends Sprite {
		private var _length:int;
		private var _focusId:int = 0;
		private var _mask:Rect = new Rect(100, 100);
		private var _wrapper:Sprite = new Sprite;
		private var _autoScroll:AutoScroll;
		static private var _instance:BtnSet = new BtnSet();
		public function BtnSet() {
			if (!_instance) {
				
			}else {
				throw new Error("singleton");
			}
		}
		public function init():void {
			setChildren();
			addChildren();
			addListeners();
		}
		
		private function addChildren():void {
			addChild(_mask);
			addChild(_wrapper);
		}
		
		private function setChildren():void{	
			buildUI();
			_mask.width = (Math.min(_length, Math.floor(_bcastr4.stage.stageWidth/BcastrConfig.btnDistance) -1) - 1) * BcastrConfig.btnDistance + BcastrConfig.btnWidth;
			_mask.height = BcastrConfig.btnHeight;
			_wrapper.mask = _mask;
			_autoScroll = new AutoScroll(_wrapper, _mask, AutoScroll.HORIZON,16);
		}
		
		private function onBcastr4Change(e:Eventer):void {
			focusId = int(e.eventInfo);
		}
		/*private function onBtnClick(e:MouseEvent):void {			
			_bcastr4.goto(_wrapper.getChildIndex(e.currentTarget as DisplayObject));
		}
		private function onBtnMouseOver(e:MouseEvent):void {
			_bcastr4.goto(_wrapper.getChildIndex(e.currentTarget as DisplayObject));
		}*/
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
				_wrapper.addChild(btn);
			}
		}
		
		override public function get width():Number {
			return _mask.width; 
		}
		
		override public function set width(value:Number):void {
			super.width = value;
		}
		
		public function set focusId(num:int):void {
			(_wrapper.getChildAt(_focusId) as GradientRadialBtn).isFocus = false;
			_focusId = num;
			(_wrapper.getChildAt(_focusId) as GradientRadialBtn).isFocus = true;
		}
		
		static public function get instance():BtnSet { return _instance; }
	}
}
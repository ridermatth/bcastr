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
		private var _wrapperMask:Rect = new Rect(100, 100);
		private var _wrapper:Sprite = new Sprite;
		private var _autoScroll:AutoScroll;
		private var _width:int;
		private var _height:int;
		private var _btnGap:int
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
		}
		
		private function addChildren():void {
			addChild(_wrapperMask);
			addChild(_wrapper);
		}
		
		private function setChildren():void{	
			buildUI();
			//_wrapperMask.width = (Math.min(_length, Math.floor(_bcastr4.stage.stageWidth/BcastrConfig.btnDistance) -1) - 1) * BcastrConfig.btnDistance + BcastrConfig.btnWidth;
			_wrapper.mask = _wrapperMask;
			_wrapperMask.alpha = .5;
			_autoScroll = new AutoScroll(_wrapper, _wrapperMask, AutoScroll.HORIZON,16);
		}
		
		override public function get width():Number { return _width; }
		
		override public function set width(value:Number):void { trace(value);
			_width = value;
			_wrapperMask.width = _width;
			_wrapper.x = _width - _wrapper.width;
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void {
			_height = value;
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
			for (var i:int = 0; i < _length; i++) { trace('b');
				var btn:GradientRadialBtn = new GradientRadialBtn();
				btn.x = _btnGap * i;
				btn.text = String(i + 1);
				/*if(BcastrConfig.changImageMode == BcastrConfig.CLICK){
					btn.addEventListener(MouseEvent.CLICK, onBtnClick, false, 0, true);
				}else {
					btn.addEventListener(MouseEvent.MOUSE_OVER, onBtnMouseOver, false, 0, true);
				}*/
				_wrapper.addChild(btn);
			}
			width = _width;
		}
		
		public function set focusId(num:int):void {
			(_wrapper.getChildAt(_focusId) as GradientRadialBtn).isFocus = false;
			_focusId = num;
			(_wrapper.getChildAt(_focusId) as GradientRadialBtn).isFocus = true;
		}
		
		static public function get instance():BtnSet { return _instance; }
		
		public function get wrapperMask():Rect { return _wrapperMask; }
		
		public function set btnGap(value:int):void {
			_btnGap = value;
		}
		
		public function get length():int { return _length; }
		
		public function set length(value:int):void {
			_length = value;
		}
	}
}
﻿package com.ruochi.component{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	public class AutoScroll extends EventDispatcher {
		public static const HORIZON:String = "horizon";
		public static const VERTICAL:String = "vertical";
		private var _content:DisplayObject;
		private var _mask:Shape;
		private var _direction:String;
		private var _maxSpeed:Number;
		private var _easeSpeed:Number = 3;
		private var _isEnterFrame:Boolean = false;
		private var _isMouseOver:Boolean = false;
		private var _mouseOffset:Number;
		private var _gValue:Number;
		public function AutoScroll(content:DisplayObject, mask:Shape, direction:String, maxSpeed:Number = 32 ) {
			_content = content;
			_mask = mask;
			_direction = direction;
			_maxSpeed = maxSpeed;
			init();
		}
		
		private function init():void {
			
			addListeners();
		}
		
		private function addListeners():void {
			if(_mask.stage){
				_mask.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMaskMouseMove);
			}else {
				_mask.addEventListener(Event.ADDED_TO_STAGE, onMaskAddToStage, false, 0, true);
			}
		}
		
		private function onMaskAddToStage(e:Event):void {
			_mask.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMaskMouseMove);
		}
		
		private function onMaskMouseMove(e:MouseEvent):void {
			if (_mask.hitTestPoint(_mask.stage.mouseX, _mask.stage.mouseY)) {
				_isMouseOver = true;
				if (!_isEnterFrame) {
					if (_direction == HORIZON) {
						if (_content.width > _mask.width) {
							_mask.addEventListener(Event.ENTER_FRAME, onMaskEnterFrame);
						}
					}else{
						if (_content.height > _mask.height) {
							_mask.addEventListener(Event.ENTER_FRAME, onMaskEnterFrame);
						}
					}
					_isEnterFrame = true
				}
			}else {
				_isMouseOver = false;
			}
		}		
		private function onMaskEnterFrame(e:Event):void {			
			if (_direction == VERTICAL) {
				if(_isMouseOver){
					_mouseOffset = (_mask.height/2 - _mask.mouseY)/(_mask.height / 2);
					_gValue = _content.y + _mouseOffset * _maxSpeed;
				}
				
				
				if (_gValue > _mask.y) {
					_gValue = _mask.y;
				}else if(_gValue + _content.height< _mask.y + _mask.height) {
					_gValue = _mask.y + _mask.height - _content.height;
				}
				if (Math.abs(_gValue - _content.y) < .1) {
					_content.y = _gValue;
					removeEnterFrame();
				}else {
					_content.y += (_gValue - _content.y) / _easeSpeed;
				}				
			}else {
				if(_isMouseOver){
					_mouseOffset = (_mask.width / 2 - _mask.mouseX)/(_mask.width / 2);
					_gValue = _content.x + _mouseOffset * _maxSpeed;		
				}						
				if (_gValue > _mask.x) {
					_gValue = _mask.x;
				}else if(_gValue + _content.width< _mask.x + _mask.width) {
					_gValue = _mask.x + _mask.width - _content.width;
				}				
				if (Math.abs(_gValue - _content.x) < .1) {
					_content.x = _gValue;
					removeEnterFrame();					
				}else {
					_content.x += (_gValue - _content.x) / _easeSpeed;
				}	
			}
		}
		private function removeEnterFrame():void {
			_mask.removeEventListener(Event.ENTER_FRAME, onMaskEnterFrame);
			_isEnterFrame = false;
		}
	}
}
package com.ruochi.bcastr.trans {
	import flash.display.Sprite;
	public interface ITransform {		
		public function in(sprite:Sprite):void ;
		public function out(sprite:Sprite):void;		
	}	
}
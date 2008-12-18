package com.ruochi.bcastr{
	import com.ruochi.bcastr.ImageContainer;
	import com.ruochi.shape.RoundRect;	
	import com.ruochi.bcastr.Title;
	import com.ruochi.bcastr.BtnSet;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ruochi.component.SimpleAlert;
	import com.ruochi.bcastr.BcastrConfig;
	import com.ruochi.utils.about;
	import flash.text.Font;
	public class Bcastr4 extends Sprite {
		private var _imageContainer:ImageContainer = new ImageContainer();
		private var _imageMask:RoundRect = new RoundRect();
		private static var _instance:Bcastr4;
		[Embed(source = "../../../font/SG16.TTF", fontName = "SG16", mimeType = "application/x-font", unicodeRange = "U+0030-U+003A")]
		private var myFont:Class;
		public function Bcastr4() {
			_instance = this;
			if (myFont) {
				Font.registerFont(myFont);
			}
			if (stage) {
				init();
			}else {
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage, false, 0, true);
			}
		}
		
		private function onAddToStage(e:Event):void {
			init();
		}
		
		private function init():void {
			Controller.init(stage); 
			setChildren();
			addChildren();
		}
		private function setChildren():void {
			
		}
		private function addChildren():void {
			addChild(_imageContainer);
			if(BcastrConfig.isShowTitle){
				addChild(Title.instance);	
			}
			if (BcastrConfig.isShowBtn) {
				addChild(BtnSet.instance);			
			}
		}
		
		public function goto(num:int):void {
			_imageContainer.goto(num);
		}
		public function get imageContainer():ImageContainer {
			return _imageContainer;
		}
		public function get numImage():int {
			return Controller.dataXml.channel.item.length();
		}
		public static function get instance():Bcastr4 {
			return _instance;
		}
		
		public function get imageMask():RoundRect { return _imageMask; }
	}
}
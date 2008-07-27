package com.ruochi.bcastr{
	import com.ruochi.bcastr.IBcastrPlugIn;
	import com.ruochi.bcastr.ImageContainer;
	import com.ruochi.utils.replaceHat;
	import com.ruochi.events.Eventer;
	import com.ruochi.utils.searchImageUrl;
	import com.ruochi.shape.RoundRect;	
	import com.ruochi.bcastr.Title;
	import com.ruochi.bcastr.BtnSet;	
	import com.ruochi.utils.formatImageRss;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	import com.ruochi.component.SimpleAlert;
	import com.ruochi.bcastr.BcastrConfig;
	import com.ruochi.layout.place;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.bcastr.Trans;
	import com.ruochi.utils.about;
	import flash.text.Font;
	public class Bcastr4 extends Sprite {
		private var _imageContainer:ImageContainer = new ImageContainer();
		private var _title:Title = new Title;
		private var _btnSet:BtnSet = new BtnSet;
		private var _imageMask:RoundRect;
		private static var _instance:Bcastr4;
		[Embed(source = "../../../font/SG16.TTF", fontName = "SG16", mimeType = "application/x-font", unicodeRange = "U+0030-U+003A")]
		private var myFont:Class;
		public function Bcastr4() {
			_instance = this;
			init();
		}
		private function init():void {
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Security.allowDomain('*');					
			stage.addChild(SimpleAlert.instance);
			if (myFont) {
				Font.registerFont(myFont);
			}
			if (loaderInfo.parameters["xml"]) {
				var xmlStr:String = replaceHat(String(loaderInfo.parameters["xml"]));
				var dataXml:XML = new XML(xmlStr);				
				if (dataXml.channel.item.length() > 0) {
					startUp(dataXml);
				}else {
					BcastrConfig.xml = xmlStr;
				}
			}
			if (BcastrConfig.dataXml==null) {
				var xmlLoader:URLLoader = new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE, onXmlLoaderComplete, false, 0, true);
				xmlLoader.load(new URLRequest(BcastrConfig.xml));
			}
		}
		private function setChildren():void {
			
		}
		private function addChildren():void {
			addChild(_imageContainer);
			if(BcastrConfig.isShowTitle){
				addChild(_title);	
			}
			if (BcastrConfig.isShowBtn) {
				addChild(_btnSet);			
			}
		}
		private function configListener():void {
			_imageContainer.addEventListener(Eventer.CHANGE,onImageContainerChanged,false,0,true)
		}
		private function onXmlLoaderComplete(event:Event):void {
			startUp(new XML(event.target.data));
		}
		private function startUp(xml:XML):void {
			formatImageRss(xml);
			if(xml.config[0]){
				xmlToVar(xml.config[0], BcastrConfig);
			}
			BcastrConfig.dataXml = xml;
			setChildren();
			addChildren();
			configListener();
			_btnSet.init();
			place(_btnSet, BcastrConfig.btnMargin, stage);
			_imageContainer.dataXml = BcastrConfig.dataXml;
			_imageContainer.imageWidth = isNaN(BcastrConfig.imageWidth)?stage.stageWidth:BcastrConfig.imageWidth;
			_imageContainer.imageHeight = isNaN(BcastrConfig.imageHeight)?stage.stageHeight:BcastrConfig.imageHeight;
			BcastrConfig.imageWidth = _imageContainer.imageWidth;
			BcastrConfig.imageHeight = _imageContainer.imageHeight;
			_imageContainer.autoPlayTime = BcastrConfig.autoPlayTime;
			_imageContainer.heightQuality = BcastrConfig.isHeightQuality;
			_imageContainer.transDuration = BcastrConfig.transDuration;
			_imageContainer.windowOpen = BcastrConfig.windowOpen;
			_imageContainer.imageBlendMode = BcastrConfig.blendMode;
			_title.init(_imageContainer.imageWidth);
			_imageMask = new RoundRect(_imageContainer.imageWidth, imageContainer.imageHeight, BcastrConfig.roundCorner)
			mask = _imageMask;
			if(BcastrConfig.transform == Trans.BLUR){
				_imageContainer.imageIn = Trans.imageBlurIn;
				_imageContainer.imageOut = Trans.imageBlurOut;
			}else if (BcastrConfig.transform == Trans.LEFT) {
				_imageContainer.imageIn = Trans.imageSlideLeftIn;
				_imageContainer.imageOut = Trans.imageSlideLeftOut;
			}else if (BcastrConfig.transform == Trans.RIGHT) {
				_imageContainer.imageIn = Trans.imageSlideRightIn;
				_imageContainer.imageOut = Trans.imageSlideRightOut;
			}else if (BcastrConfig.transform == Trans.TOP) {
				_imageContainer.imageIn = Trans.imageSlideTopIn;
				_imageContainer.imageOut = Trans.imageSlideTopOut;
			}else if (BcastrConfig.transform == Trans.BOTTOM) {
				_imageContainer.imageIn = Trans.imageSlideBottomIn;
				_imageContainer.imageOut = Trans.imageSlideBottomOut;
			}else if (BcastrConfig.transform == Trans.BREATHE) {
				_imageContainer.imageIn = Trans.imageBreatheIn;
				_imageContainer.imageOut = Trans.imageBreatheOut;
			}else if (BcastrConfig.transform == Trans.BREATHE_BLUR) {
				_imageContainer.imageIn = Trans.imageBreatheBlurIn;
				_imageContainer.imageOut = Trans.imageBreatheBlurOut;
			}else {
				_imageContainer.imageIn = Trans.imageAlphaIn;
				_imageContainer.imageOut = Trans.imageAlphaOut;
			}
			_imageContainer.scaleMode = BcastrConfig.scaleMode;
			_imageContainer.run();
			if (BcastrConfig.isShowAbout) {
				about(this, "About Bcastr 4.0", "http://code.google.com/p/bcastr/");
			}
		}
		private function onImageContainerChanged(e:Eventer):void {
			dispatchEvent(new Eventer(Eventer.CHANGE,_imageContainer.focusId));
		}
		public function goto(num:int):void {
			_imageContainer.goto(num);
		}
		public function get imageContainer():ImageContainer {
			return _imageContainer;
		}
		public function get numImage():int {
			return BcastrConfig.dataXml.channel.item.length();
		}
		public static function get instance():Bcastr4 {
			return _instance;
		}
	}
}
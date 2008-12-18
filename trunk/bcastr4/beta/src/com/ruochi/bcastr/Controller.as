package com.ruochi.bcastr {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.Font;
	import flash.system.Security;
	import com.ruochi.component.SimpleAlert;
	import com.ruochi.string.replaceHat;
	import flash.display.LoaderInfo;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.ruochi.events.Eventer;
	import com.ruochi.utils.xmlToVar;
	import com.ruochi.layout.place;
	import com.ruochi.utils.formatImageRss;
	import com.ruochi.utils.about;
	public class Controller {
		private static var _stage:Stage;
		private static var _dataXml:XML;
		private static var _length:int;
		static public function init(stage:Stage):void {
			_stage = stage;			
			_stage.align=StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			Security.allowDomain('*');					
			stage.addChild(SimpleAlert.instance);			
			if (_stage.loaderInfo.parameters["xml"]) {
				var xmlStr:String = replaceHat(String(_stage.loaderInfo.parameters["xml"]));
				var dataXml:XML = new XML(xmlStr);	
				_length = dataXml.channel.item.length();
				if (_length > 0) {
					startUp(dataXml);
				}else {
					BcastrConfig.xml = xmlStr;
				}
			}
			if (_dataXml==null) {//BcastrConfig.xml = "http://www.yupoo.com/services/feeds/photos?explore=1"
				var xmlLoader:URLLoader = new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE, onXmlLoaderComplete, false, 0, true);
				xmlLoader.load(new URLRequest(BcastrConfig.xml));
			}
		}
			
		static private function onXmlLoaderComplete(event:Event):void {
			startUp(new XML(event.target.data));
			addListenre();
		}
		static private function addListenre():void {
			Bcastr4.instance.imageContainer.addEventListener(Eventer.CHANGE, onImageContainerChanged, false, 0, true);
			if(BcastrConfig.changImageMode == BcastrConfig.CLICK){
				BtnSet.instance.addEventListener(MouseEvent.CLICK, onBtnSetChange, false, 0, true);
			}else {
				BtnSet.instance.addEventListener(MouseEvent.MOUSE_OVER, onBtnSetChange, false, 0, true);
			}
		}
		
		static private function onBtnSetChange(e:MouseEvent):void {
			var displayObject:DisplayObject = e.target as DisplayObject;
			var id:int = displayObject.parent.getChildIndex(displayObject);
			Bcastr4.instance.imageContainer.goto(id);
		}
		static private function onImageContainerChanged(e:Eventer):void {
			var id:int = Bcastr4.instance.imageContainer.focusId;
			BtnSet.instance.focusId = id;
			Title.instance.titleText = _dataXml.channel[0].item[id].title[0];
		}
		static private function startUp(xml:XML):void {
			formatImageRss(xml);
			if(xml.config[0]){
				xmlToVar(xml.config[0], BcastrConfig);
			}
			_dataXml = xml;
			_length = dataXml.channel.item.length(); 
			BcastrConfig.imageWidth = BcastrConfig.imageWidth ?BcastrConfig.imageWidth:_stage.stageWidth;
			BcastrConfig.imageHeight = BcastrConfig.imageHeight ?BcastrConfig.imageHeight:_stage.stageHeight;
			Bcastr4.instance.imageContainer.dataXml = _dataXml;
			Bcastr4.instance.imageContainer.imageWidth = BcastrConfig.imageWidth;
			Bcastr4.instance.imageContainer.imageHeight = BcastrConfig.imageHeight;
			BcastrConfig.imageWidth = Bcastr4.instance.imageContainer.imageWidth;
			BcastrConfig.imageHeight = Bcastr4.instance.imageContainer.imageHeight;
			Bcastr4.instance.imageContainer.autoPlayTime = BcastrConfig.autoPlayTime;
			Bcastr4.instance.imageContainer.heightQuality = BcastrConfig.isHeightQuality;
			Bcastr4.instance.imageContainer.transDuration = BcastrConfig.transDuration;
			Bcastr4.instance.imageContainer.windowOpen = BcastrConfig.windowOpen;
			Bcastr4.instance.imageContainer.imageBlendMode = BcastrConfig.blendMode;
			Bcastr4.instance.imageMask.width = Bcastr4.instance.imageContainer.imageWidth;
			Bcastr4.instance.imageMask.height = Bcastr4.instance.imageContainer.imageHeight;
			Bcastr4.instance.imageMask.corner = BcastrConfig.roundCorner;
			if(BcastrConfig.transform == Trans.BLUR){
				Bcastr4.instance.imageContainer.imageIn = Trans.imageBlurIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageBlurOut;
			}else if (BcastrConfig.transform == Trans.LEFT) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageSlideLeftIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageSlideLeftOut;
			}else if (BcastrConfig.transform == Trans.RIGHT) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageSlideRightIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageSlideRightOut;
			}else if (BcastrConfig.transform == Trans.TOP) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageSlideTopIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageSlideTopOut;
			}else if (BcastrConfig.transform == Trans.BOTTOM) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageSlideBottomIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageSlideBottomOut;
			}else if (BcastrConfig.transform == Trans.BREATHE) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageBreatheIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageBreatheOut;
			}else if (BcastrConfig.transform == Trans.BREATHE_BLUR) {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageBreatheBlurIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageBreatheBlurOut;
			}else {
				Bcastr4.instance.imageContainer.imageIn = Trans.imageAlphaIn;
				Bcastr4.instance.imageContainer.imageOut = Trans.imageAlphaOut;
			}
			Bcastr4.instance.imageContainer.scaleMode = BcastrConfig.scaleMode;
			Bcastr4.instance.imageContainer.run();
			if (BcastrConfig.isShowAbout) {
				about(Bcastr4.instance, "About Bcastr 4.0", "http://code.google.com/p/bcastr/");
			}
			
			
			Title.instance.width = BcastrConfig.imageWidth;
			
			Title.instance.bg.color = BcastrConfig.titleBgColor;
			Title.instance.bg.alpha = BcastrConfig.titleBgAlpha;
			Title.instance.styleText.color = BcastrConfig.titleTextColor;
			Title.instance.styleText.font = BcastrConfig.titleFont
			Title.instance.init();
			
			BtnSet.instance.width = BcastrConfig.imageWidth;
			BtnSet.instance.height = BcastrConfig.btnHeight;
			BtnSet.instance.length = _length;
			BtnSet.instance.btnGap = BcastrConfig.btnDistance;
			BtnSet.instance.init();
			place(BtnSet.instance, BcastrConfig.btnMargin, _stage);
		}
		
		static public function get dataXml():XML { return _dataXml; }
	}	
}
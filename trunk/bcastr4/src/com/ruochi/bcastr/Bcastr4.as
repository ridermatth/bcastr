package com.ruochi.bcastr{
	import com.ruochi.bcastr.IBcastrPlugIn;
	import com.ruochi.component.GradientRadialBtn;
	import com.ruochi.component.ImageContainer;
	import com.ruochi.component.CircleProgressBar;
	import com.ruochi.utils.defaultNum;
	import com.ruochi.utils.defaultBoolean;
	import com.ruochi.utils.defaultString;
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
	public class Bcastr4 extends Sprite {
		private var _imageContainer:ImageContainer = new ImageContainer();
		private var _isShowProgressBar:Boolean;
		private var _titleArray:Array = new Array();
		private var _circleProgressBar:CircleProgressBar;
		private var _circleProgressBarColor:uint=0xffffff;
		private var _windowOpen:String = "_blank";
		private var _title:Title;
		private var _xmlLdr:URLLoader = new URLLoader();
		private var _dataXml:XML;
		private var _dataXmlUrl:String = "bcastr.xml";
		private var _plugInArray:Array = new Array();
		private var _id:String = "bcastr4";
		private var _btnSet:BtnSet = new BtnSet;
		private var _imageMask:RoundRect;
		private var _roundCorner:Number = 0;
		public function Bcastr4() {			
			addEventListener(Event.ADDED_TO_STAGE , init);
		}
		private  function init(e:Event = null) {
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Security.allowDomain('*');
			initVar();
			_plugInArray.push(_title);
			if (_isShowProgressBar) {
				_circleProgressBar = new CircleProgressBar(_imageContainer.imageWidth, _imageContainer.imageHeight);
				_circleProgressBar.bg.visible = false;
				addChild(_circleProgressBar);			
				_imageContainer.addEventListener("beginLoading", onBeginLoadin, false, 0, true);
				_imageContainer.addEventListener("endLoading", onBeginLoadin, false, 0, true);
			}
			addChild(_imageContainer);
			//addChild(_title);
			_imageContainer.addEventListener("onChanged",onChanged,false,0,true)
			if (!loaderInfo.parameters["bcastrFile"]) {
				_xmlLdr.addEventListener(Event.COMPLETE, onXmlLoaded, false, 0, true);
				_dataXmlUrl = "data.xml";
				_xmlLdr.load(new URLRequest(_dataXmlUrl));
			}else {
				run();
			}
		}
		private function initVar() {
			_imageContainer.imageWidth = defaultNum(this.loaderInfo.parameters["width"], this.stage.stageWidth);
			_imageContainer.imageHeight = defaultNum(this.loaderInfo.parameters["height"],this.stage.stageHeight);
			_roundCorner =  defaultNum(this.loaderInfo.parameters["roundCorner"], _roundCorner);
			_imageContainer.autoPlayTime = defaultNum(this.loaderInfo.parameters["autoPlayTime"], _imageContainer.autoPlayTime);			
			_imageContainer.heightQuality = defaultBoolean(this.loaderInfo.parameters["heightQuality"], false);
			_imageContainer.imageBlendMode = defaultString(this.loaderInfo.parameters["blendMode"], "normal");
			_imageContainer.transDuration = defaultNum(this.loaderInfo.parameters["transDuration"], 1.5);
			_windowOpen = defaultString(this.loaderInfo.parameters["windowOpen"], "_blank");
			_imageContainer.dataXml = _dataXml;
			//_imageContainer.linkArray = defaultString(this.loaderInfo.parameters["bcastrLink"], "").split("|");
			//_titleArray = defaultString(this.loaderInfo.parameters["bcastrTitle"], "").split("|");
			_isShowProgressBar = defaultBoolean(this.loaderInfo.parameters["isShowProgressBar"], "true");
			_circleProgressBarColor = defaultNum(this.loaderInfo.parameters["autoPlayTime"], _circleProgressBarColor);
			_id = defaultString(this.loaderInfo.parameters["id"], _id);
			stage.frameRate = defaultNum(this.loaderInfo.parameters["frameRate"], "24");
			_title = new Title(_imageContainer.imageWidth);
		}
		private function onXmlLoaded(event:Event) {
			_dataXml = new XML(event.target.data);
			formatImageRss(_dataXml);
			_imageContainer.dataXml = _dataXml;
			run();
		}
		private function run():void {
			//_btnSet = new BtnSet(_dataXml.channel.item.length());
			//addChild(_btnSet);			
			_plugInArray.push(_btnSet);
			_btnSet.y = 100;
			_imageContainer.run();			
			sentEventer( { type:"init" } );
		}
		private function onBeginLoadin(e:Event) {
			_circleProgressBar.start();
		}
		private function onEndLoadin(e:Event) {
			_circleProgressBar.stop();
		}
		private function onChanged(e:Event) {
			sentEventer({type:"change", xml:_dataXml.channel.item[_imageContainer.focusId],id:_imageContainer.focusId});
		}
		public function sentEventer(event:Object):void {
			for (var i:int = 0; i < _plugInArray.length; i++) {
				(_plugInArray[i] as IBcastrPlugIn).recieveEventer(event);
			}
		}
		public function goto(num:int):void {
			_imageContainer.goto(num);
		}
		public function get imageContainer():ImageContainer {
			return _imageContainer;
		}
		public function get numImage():int {
			return _dataXml.channel.item.length();
		}
	}
}
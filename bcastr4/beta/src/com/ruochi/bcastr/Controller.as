package com.ruochi.bcastr {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.Font;
	import flash.system.Security;
	import com.ruochi.component.SimpleAlert;
	public class Controller {
		private static var _stage:Stage;
		static public function init(stage:Stage):void {
			_stage = stage;			
			_stage.align=StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			Security.allowDomain('*');					
			stage.addChild(SimpleAlert.instance);
			if (myFont) {
				Font.registerFont(myFont);
			}
			if (_stage.loaderInfo.parameters["xml"]) {
				var xmlStr:String = replaceHat(String(loaderInfo.parameters["xml"]));
				var dataXml:XML = new XML(xmlStr);		
				if (dataXml.channel.item.length() > 0) {
					startUp(dataXml);
				}else {
					BcastrConfig.xml = xmlStr;
				}
			}
			if (BcastrConfig.dataXml==null) {BcastrConfig.xml = "http://www.yupoo.com/services/feeds/photos?explore=1"
				var xmlLoader:URLLoader = new URLLoader();
				xmlLoader.addEventListener(Event.COMPLETE, onXmlLoaderComplete, false, 0, true);
				xmlLoader.load(new URLRequest(BcastrConfig.xml));
			}
		}
		
	}
	
}
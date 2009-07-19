package com.ruochi.bcastr {
	import com.ruochi.layout.Margin;
	import com.ruochi.layout.ScaleUtils;
	import com.ruochi.bcastr.Trans;
	public class BcastrConfig {
		public static const HOVER:String = "hover";
		public static const CLICK:String = "click";
		public static var roundCorner:Number =0;
		public static var autoPlayTime:Number = 8;
		public static var isHeightQuality:Boolean =false;
		public static var blendMode:String ="normal";
		public static var transDuration:Number = 1;
		public static var windowOpen:String = "_self";
		public static var dataXml:XML;
		public static var xml:String = "bcastr.xml";
		public static var btnMargin:Margin = new Margin("auto 5 5 auto");
		public static var imageWidth:Number;
		public static var imageHeight:Number;
		public static var btnDistance:Number = 20;
		public static var titleBgColor:uint = 0xff6600;
		public static var titleBgAlpha:Number = .75;
		public static var titleMoveDuration:Number = 1;
		public static var titleTextColor:uint = 0xffffff;
		public static var btnWidth:Number = 16;
		public static var btnHeight:Number = 16;
		public static var btnTextColor:uint = 0xffffff;
		public static var btnDefaultColor:uint = 0x1B3433;
		public static var btnHoverColor:uint = 0xff9900;
		public static var btnFocusColor:uint = 0xff6600;
		public static var btnAlpha:Number = .75;
		public static var btnFontSize:uint = 10;
		public static var changImageMode:String = CLICK;
		public static var isShowBtn:Boolean = true;
		public static var isShowTitle:Boolean = true;
		public static var scaleMode:String = ScaleUtils.NO_BORDER;
		public static var transform:String = Trans.ALPHA;
		public static var isShowAbout:Boolean = true;
		public static var titleFont:String = "微软雅黑";
		public static function set btnSetMargin(s:String):void {
			btnMargin = new Margin(s);
		}
	}	
}
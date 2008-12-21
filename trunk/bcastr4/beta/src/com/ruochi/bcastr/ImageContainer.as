package com.ruochi.bcastr {
	import com.ruochi.shape.RoundRect;
	import com.ruochi.events.Eventer;
	import com.ruochi.utils.resizeBitmap;
	import com.robertpenner.easing.*
	import com.ruochi.events.Eventer;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import gs.TweenLite;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;	
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Timer;
	import flash.utils.ByteArray;
	import flash.net.navigateToURL;
	import com.ruochi.layout.ScaleUtils;
	public class ImageContainer extends Sprite {
		private var _loadId:int = 0;
		private var _focusId:int = -1;
		private var _width:Number =100;
		private var _height:Number =100;
		private var _autoPlayTime:Number = 8;
		private var _loader:Loader;
		private var _transTimer:Timer;
		private var _heightQuality:Boolean;
		private var _imageBlendMode:String = "normal"
		private var _transDuration:Number = 1.5;
		private var _windowOpen:String = "_blank";
		private var _dataXml:XML = new XML();		
		public var imageIn:Function;
		public var imageOut:Function;
		private var _imageArray:Array = new Array();
		private var _scaleMode:String = ScaleUtils.NO_BORDER;
		
		public function ImageContainer() {
			init();
		}
		private function init():void {
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		private function onLoaderIOError(e:IOErrorEvent):void {
			_loadId++;
			loadImage();
		}
		
		override public function get width():Number { return _width; }
		
		override public function set width(value:Number):void {
			_width = value;
			setAllImageSize();
		}
		
		override public function get height():Number { return _height; }
		
		override public function set height(value:Number):void {
			_height = value;			
			setAllImageSize();
		}
		
		private function setAllImageSize():void {
			var i:int;
			var sprite:Sprite;
			if(_focusId>-1){
				sprite =  getChildAt(numChildren-1) as Sprite;
				setImageSize(sprite);
			}
		}
		
		private function setImageSize(image:Sprite):void {			
			var bitmap:Bitmap;
			var i:int;
			var length:int = image.numChildren;
			image.scrollRect = new Rectangle(0, 0, _width, _height);
			for (i = 0; i < length; i++) {
				bitmap = image.getChildAt(i) as Bitmap;
				//bitmap.scrollRect = new Rectangle(0, 0, _width, _height);
				if (_scaleMode == ScaleUtils.NO_SCALE) {
					ScaleUtils.fillNoScale(bitmap, _width, _height);
				}else if(_scaleMode == ScaleUtils.EXACT_FIT) {
					ScaleUtils.fillExactFit(bitmap, _width, _height);
					/*if (bitmap.scaleX<.5&&_heightQuality==true) {
						bitmap.bitmapData = resizeBitmap(bitmap.bitmapData, bitmap.width, bitmap.height);
						ScaleUtils.fillExactFit(bitmap, _width, _height);
					}*/
				}else if (_scaleMode == ScaleUtils.NO_BORDER) {				
					ScaleUtils.fillNoBorder(bitmap, _width, _height);trace( _width, _height);
					/*if (bitmap.scaleX<.5&&_heightQuality==true) {
						bitmap.bitmapData = resizeBitmap(bitmap.bitmapData, bitmap.width, bitmap.height);
						ScaleUtils.fillNoBorder(bitmap, _width, _height);
					}*/
				}else if (_scaleMode == ScaleUtils.SHOW_ALL) {
					ScaleUtils.fillShowAll(bitmap, _width, _height);
					/*if (bitmap.scaleX<.5&&_heightQuality==true) {
						bitmap.bitmapData = resizeBitmap(bitmap.bitmapData, bitmap.width, bitmap.height);
						ScaleUtils.fillShowAll(bitmap, _width, _height);
					}*/
				}
			}			
		}
		
		private function onLoaderComplete(e:Event):void {
			var image:Sprite = new Sprite();
			image.name = String(_loadId);
			var bitmap:Bitmap = e.target.loader.content as Bitmap;
			bitmap.smoothing = true;
			image.addChild(bitmap);
			//bitmap.visible = false;
			bitmap.alpha = 0;
			image.blendMode = _imageBlendMode;
			_imageArray.push(image);
			if (_loadId==0) {
				goto(0);
				_transTimer.start();
			}
			_loadId++;
			dispatchEvent(new Eventer(Eventer.COMPLETE));
			if (_loadId< _dataXml.channel.item.length()) {
				loadImage(); trace(_dataXml.channel.item.length());
			}
		}
		private function loadImage():void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete, false, 0, true);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOError, false, 0,  true);
			_loader.load(new URLRequest(_dataXml.channel.item[_loadId].image[0]));
			dispatchEvent(new Eventer(Eventer.START));
		}
		private function timerHandler(e:Event):void {			
			goto((_focusId + 1) % _imageArray.length);
		}
		private function onClick(e:MouseEvent):void {
			navigateToURL(new URLRequest(_dataXml.channel.item[_focusId].link[0]),_windowOpen);
		}
		public function run():void {			
			_transTimer = new Timer(_autoPlayTime * 1000, 0);
			_transTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			loadImage();
		}
		public function goto(id:int):void { 
			if (id!=_focusId) {
				if(focusId>-1){
					imageOut(getChildAt(numChildren-1));
				}
				_focusId = id; 
				var focusImage:Sprite = _imageArray[_focusId] as Sprite;
				addChild(focusImage);
				setChildIndex(focusImage, numChildren-1);
				setImageSize(focusImage);
				imageIn(focusImage);			
				_transTimer.reset();
				_transTimer.start();				
				if (_dataXml.channel.item[_focusId].link[0] != undefined) {
					buttonMode = true;
					mouseEnabled = true;
				}else {
					buttonMode = false;
					mouseEnabled = false;				}
				dispatchEvent(new Eventer(Eventer.CHANGE,_focusId));
			}
		}
		public function set autoPlayTime(num:Number):void {
			_autoPlayTime = num;
		}
		public function set heightQuality(boo:Boolean):void {
			_heightQuality = boo;
		}
		public function set dataXml(xml:XML):void {
			_dataXml = xml;
		}
		public function set transDuration(num:Number):void {
			_transDuration = num;
		}
		public function set imageBlendMode(str:String):void {
			_imageBlendMode = str;
		}
		public function get focusId():int {
			return _focusId;
		}
		public function set windowOpen(s:String):void {
			_windowOpen = s;
		}
		public function set scaleMode(s:String):void {
			_scaleMode = s;
		}
	}
}
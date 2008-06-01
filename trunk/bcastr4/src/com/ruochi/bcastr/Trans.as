package com.ruochi.bcastr {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BlurFilter;
	import gs.*;
	import com.ruochi.bcastr.BcastrConfig;
	import flash.display.Sprite;
	import com.ruochi.bcastr.BcastrConfig;
	import fl.motion.easing.*;
	public class Trans {
		public static function imageAlphaIn(displayObject:DisplayObjectContainer):void {
			TweenLite.to(displayObject.getChildAt(0),BcastrConfig.transDuration,{autoAlpha:1, overwrite:true});
		}
		public static function imageAlphaOut(displayObject:DisplayObjectContainer):void {
			TweenLite.to(displayObject.getChildAt(0),BcastrConfig.transDuration,{autoAlpha:0, overwrite:true});
		}
		public static function imageBlurIn(sprite:Sprite):void {
			if(sprite.numChildren<2){
				var bmp:Bitmap = sprite.getChildAt(0) as Bitmap
				var bitmap:Bitmap = new Bitmap(bmp.bitmapData.clone());
				bitmap.smoothing = false;
				bitmap.width = bmp.width;
				bitmap.height = bmp.height;
				bitmap.x = bmp.x;
				bitmap.y = bmp.y;
				bitmap.alpha = 0;
				bitmap.visible = false;
				sprite.addChild(bitmap);
				sprite.setChildIndex(bitmap, 0);
				bitmap.filters = [new BlurFilter(50, 50, 2)];
				
			}
			TweenLite.to(sprite.getChildAt(0), BcastrConfig.transDuration / 2, { autoAlpha:1, overwrite:true, ease:Linear.easeNone } );
			//TweenFilterLite.to(sprite.getChildAt(0), BcastrConfig.transDuration/2, { blurFilter:{blurX:10,blurY:10,quality:2}, overwrite:false,  ease:Linear.easeNone } );
			TweenLite.to(sprite.getChildAt(1), BcastrConfig.transDuration/2, { autoAlpha:1, overwrite:true, delay:BcastrConfig.transDuration/3, ease:Linear.easeNone } );
		}
		public static function imageBlurOut(sprite:Sprite):void {
			TweenLite.to(sprite.getChildAt(0), BcastrConfig.transDuration/2, { autoAlpha:0, overwrite:true, delay:BcastrConfig.transDuration/3, ease:Linear.easeNone} );
			TweenLite.to(sprite.getChildAt(1), BcastrConfig.transDuration/2, { autoAlpha:0, overwrite:true, ease:Linear.easeNone } );
		}
	}	
}
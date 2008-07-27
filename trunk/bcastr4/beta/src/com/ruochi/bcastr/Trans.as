package com.ruochi.bcastr {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.BlurFilter;
	import gs.TweenLite;
	import com.ruochi.bcastr.BcastrConfig;
	import flash.display.Sprite;
	import fl.motion.easing.*;
	public class Trans {
		public static const ALPHA:String = "alpha";
		public static const BLUR:String = "blur";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		public static const BREATHE:String = "breathe";
		public static const BREATHE_BLUR:String = "breatheBlur";
		private static var _easeClass:Function = Sine.easeOut;
		public static function imageAlphaIn(sprite:Sprite):void {
			TweenLite.to(sprite.getChildAt(0),BcastrConfig.transDuration,{autoAlpha:1, ease:_easeClass});
		}
		public static function imageAlphaOut(sprite:Sprite):void {
			TweenLite.to(sprite.getChildAt(0),BcastrConfig.transDuration,{autoAlpha:0, ease:_easeClass});
		}
		public static function imageBlurIn(sprite:Sprite):void {
			if(sprite.numChildren<2){
				var bmp:Bitmap = sprite.getChildAt(0) as Bitmap
				var bitmap:Bitmap = new Bitmap(bmp.bitmapData.clone(),"auto" ,false);
				bitmap.width = bmp.width;
				bitmap.height = bmp.height;
				bitmap.x = bmp.x;
				bitmap.y = bmp.y;
				bitmap.alpha = 0;
				bitmap.visible = false;
				sprite.addChild(bitmap);
				sprite.setChildIndex(bitmap, 0);
				bitmap.filters = [new BlurFilter(50, 50, 2)];				
				bitmap.cacheAsBitmap = true;
			}
			TweenLite.to(sprite.getChildAt(0), BcastrConfig.transDuration, { autoAlpha:1, overwrite:true, ease:_easeClass } );
			TweenLite.to(sprite.getChildAt(1), BcastrConfig.transDuration, { autoAlpha:1, delay:BcastrConfig.transDuration / 3, ease:_easeClass } );
			TweenLite.to(sprite.getChildAt(0), BcastrConfig.transDuration, { autoAlpha:0, delay:BcastrConfig.transDuration,overwrite:false, ease:_easeClass } );
		}
		public static function imageBlurOut(sprite:Sprite):void {
			TweenLite.to(sprite.getChildAt(1), BcastrConfig.transDuration, { autoAlpha:0, ease:_easeClass} );
		}
		public static function imageSlideLeftIn(sprite:Sprite):void {			
			slideInit(sprite);
			if(sprite.parent.numChildren>1){
				var prveSprite:Sprite = sprite.parent.getChildAt(sprite.parent.numChildren - 2) as Sprite;
				if (prveSprite) {
					sprite.x = prveSprite.x - sprite.width;				
				}
			}
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:0} );
		}
		public static function imageSlideLeftOut(sprite:Sprite):void {
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:BcastrConfig.imageWidth} );
		}
		public static function imageSlideRightIn(sprite:Sprite):void {			
			slideInit(sprite);
			if(sprite.parent.numChildren>1){
				var prveSprite:Sprite = sprite.parent.getChildAt(sprite.parent.numChildren - 2) as Sprite;
				if (prveSprite) {
					sprite.x = prveSprite.x + BcastrConfig.imageWidth;				
				}
			}
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:0} );
		}
		public static function imageSlideRightOut(sprite:Sprite):void {
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:-BcastrConfig.imageWidth} );
		}
		public static function imageSlideBottomIn(sprite:Sprite):void {			
			slideInit(sprite);
			if(sprite.parent.numChildren>1){
				var prveSprite:Sprite = sprite.parent.getChildAt(sprite.parent.numChildren - 2) as Sprite;
				if (prveSprite) {
					sprite.y = prveSprite.y + BcastrConfig.imageHeight;				
				}
			}
			TweenLite.to(sprite, BcastrConfig.transDuration, { y:0} );
		}
		public static function imageSlideBottomOut(sprite:Sprite):void {
			TweenLite.to(sprite, BcastrConfig.transDuration, { y:-BcastrConfig.imageHeight} );
		}
		
		public static function imageSlideTopIn(sprite:Sprite):void {			
			slideInit(sprite);
			if(sprite.parent.numChildren>1){
				var prveSprite:Sprite = sprite.parent.getChildAt(sprite.parent.numChildren - 2) as Sprite;
				if (prveSprite) {
					sprite.y = prveSprite.y - sprite.height;				
				}
			}
			TweenLite.to(sprite, BcastrConfig.transDuration, { y:0} );
		}
		public static function imageSlideTopOut(sprite:Sprite):void {
			TweenLite.to(sprite, BcastrConfig.transDuration, { y:BcastrConfig.imageHeight} );
		}
		private static function slideInit(sprite:Sprite):void {
			(sprite.getChildAt(0) as DisplayObject).visible = true;
			(sprite.getChildAt(0) as DisplayObject).alpha = 1;
		}
		
		private static function breatheInit(sprite:Sprite):void {
			var originalWidth:int = sprite.width;
			var originalHeight:int = sprite.height;
			sprite.scaleX = 1.2;
			sprite.scaleY = 1.2;
			sprite.x = -(sprite.width - originalWidth) / 2;
			sprite.y = -(sprite.height - originalHeight) / 2;
		}
		
		public static function imageBreatheIn(sprite:Sprite):void {
			breatheInit(sprite);
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:0, y:0, scaleX:1, scaleY:1, ease:Exponential.easeOut} );
			imageAlphaIn(sprite);			
		}
		public static function imageBreatheOut(sprite:Sprite):void {
			imageAlphaOut(sprite);	
		}
		
		public static function imageBreatheBlurIn(sprite:Sprite):void {
			breatheInit(sprite);
			TweenLite.to(sprite, BcastrConfig.transDuration, { x:0, y:0, scaleX:1, scaleY:1, ease:Exponential.easeOut} );
			imageBlurIn(sprite)		
		}
		public static function imageBreatheBlurOut(sprite:Sprite):void {
			imageBlurOut(sprite);	
		}
	}	
}
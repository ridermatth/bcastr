package com.ruochi.utils{	
	/* ruochi.com */
	import com.ruochi.utils.searchImageUrl;
	public function formatImageRss(rssXml:XML):void {		
		var i:int = 0;
		while (i < rssXml.channel[0].item.length()) {
			var imageXml:XML = rssXml.channel[0].item[i].image[0];
			if (imageXml && String(imageXml).length > 0) {
				i++;
			}else {
				var xml:XML = rssXml.channel[0].item[i].description[0];
				if(xml){
					var imageUrl:String = searchImageUrl(String(xml));
					if (imageUrl && imageUrl.length > 2) {					
						rssXml.channel[0].item[i].image[0] = imageUrl;
						delete rssXml.channel[0].item[i].description[0];	
						i++;
					}else {
						delete rssXml.channel[0].item[i];
					}			
				}else {
					delete rssXml.channel[0].item[i];
				}
			}
		}
	}	
}
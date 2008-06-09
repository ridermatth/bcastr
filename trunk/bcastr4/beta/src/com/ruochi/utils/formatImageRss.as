package com.ruochi.utils{	
	/* ruochi.com */
	import com.ruochi.utils.searchImageUrl;
	public function formatImageRss(rssXml:XML):void {
		var imageUrl:String; 
		var i:int = 0;
		while (i < rssXml.channel.item.length()) {
			if (rssXml.channel.item[i].image[0] == undefined || rssXml.channel.item[i].image[0] == "") {
				imageUrl = searchImageUrl(rssXml.channel.item[i].description[0]);
				if (imageUrl != null) {
					delete rssXml.channel.item[i].description[0];	
					rssXml.channel.item[i].image[0] = imageUrl;
					i++
				}else {
					delete rssXml.channel.item[i];
				}
			}else {
				i++
			}
		}
	}	
}
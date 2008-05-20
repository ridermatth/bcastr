package utils{	
	/* ruochi.com */
	import com.ruochi.utils.searchImageUrl;
	public function formatImageRss(rssXml:XML):void {
		var imageUrl:String; 
		for (var i:int = 0; i < rssXml.channel.item.length(); i++) {
			if (rssXml.channel.item[i].image[0] == undefined || rssXml.channel.item[i].image[0] == "") {
				imageUrl = searchImageUrl(rssXml.channel.item[i].description[0]);
				if (imageUrl != null) {
					rssXml.channel.item[i].image[0] = imageUrl;
				}
			}
		delete rssXml.channel.item[i].description[0];			
		}
	}	
}
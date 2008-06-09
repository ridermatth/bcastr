package com.ruochi.events{
	import flash.events.Event;
	public class Eventer extends Event {
		public static const COMPLETE:String = "complete";
		public static const START:String = "start";
		public static const CHECK_ENABLE:String = "checkEnable";
		public static const CHANGE:String = "change";
		private var _info:Object;
		public function Eventer(type:String, info:Object=null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_info = info;
		}
		public function get eventInfo():Object {
			return _info;
		}
		public override function toString():String {
			return formatToString("Event:", "type", "bubbles", "cancelable", "eventInfo");
		}
	}
}
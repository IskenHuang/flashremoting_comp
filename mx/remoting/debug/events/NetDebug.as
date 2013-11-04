//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

/**
  Base class for all debug events sent from action script
*/
class mx.remoting.debug.events.NetDebug extends Object {
	
	function NetDebug() {
		super();
		init();
	}
	
	function init():Void {
		eventType = "DebugEvent";
		source = "Client";
		movieUrl = unescape(_root._url);
		initDate();
	}
	
	function initDate():Void {
		var now:Date = new Date();
		date = now;
		time = now.getTime();
	}
	
	public var eventType:String;
	public var source:String;
	public var movieUrl:String;
	public var date: Date;
	public var time: Number;
}
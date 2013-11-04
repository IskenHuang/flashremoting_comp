//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebug;

/**
  NetServices generated trace event
*/
class mx.remoting.debug.events.NetDebugTraceNetServices extends NetDebug {
	
	function NetDebugTraceNetServices(w:String, s:String, n:Number, m:String) {
		super();
		eventType = "NetServicesTrace";
		trace = m;
		who = w;
		severity = s;
		number = n;
	}
	
	public var who:String;
	public var severity:String;
	public var number:Number;
	public var trace:String;
}
//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection call called event
*/
class mx.remoting.debug.events.NetDebugCall extends NetDebugNetConnection {
	
	function NetDebugCall(args:Array) {
		super();
		eventType = "Call";
		methodName = args[0];
		parameters = new Array();
		var alen:Number = args.length;
		for (var i:Number = 2; i < alen; i++) {
			parameters[i-2] = args[i];
		}
	}
	
	public var methodName:String;
	public var parameters:Array;
}
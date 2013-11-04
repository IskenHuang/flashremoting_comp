//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection arbirary received event
*/
class mx.remoting.debug.events.NetDebugReceiveCall extends NetDebugNetConnection {
	
	function NetDebugReceiveCall(mName:String, args:Array) {
		super();
		eventType = "ReceivedCall";
		methodName = mName;
		parameters = args;
	}
	
	public var methodName:String;
	public var parameters:Array;
}
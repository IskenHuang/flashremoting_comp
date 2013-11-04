//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  RTMP log stream receveived log event
*/
class mx.remoting.debug.events.NetDebugRtmpLog extends NetDebugNetConnection {
	
	function NetDebugRtmpLog(infoobj:Object) {
		super();
		eventType = "Trace";
		source = "Flash Communication Server";
		info = infoobj;
		trace = infoobj.description;
	}
	
	public var source:String;
	public var info:Object;
	public var trace:String;
}

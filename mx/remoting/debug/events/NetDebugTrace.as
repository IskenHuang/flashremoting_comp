//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebug;

/**
  User generated trace event
*/
class mx.remoting.debug.events.NetDebugTrace extends NetDebug {
	
	function NetDebugTrace(traceobj:Object) {
		super();
		eventType = "Trace";
		trace = traceobj;
	}
	
	public var trace:Object;
}
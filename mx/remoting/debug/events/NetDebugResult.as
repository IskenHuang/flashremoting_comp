//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection result received event
*/
class mx.remoting.debug.events.NetDebugResult extends NetDebugNetConnection {
	
	function NetDebugResult(resultobj:Object)	{
		super();
		eventType = "Result";
		result = resultobj;
	}
	
	public var result:Object;
}

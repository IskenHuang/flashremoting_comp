//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection status received event
*/
class mx.remoting.debug.events.NetDebugStatus extends NetDebugNetConnection {

	function NetDebugStatus(statusobj:Object)	{
		super();
		eventType = "Status";
		status = statusobj;
	}
	
	public var status:Object;
}

//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection close called event
*/
class mx.remoting.debug.events.NetDebugClose extends NetDebugNetConnection {
	
	function NetDebugClose() {
		super();
		eventType = "Close";
	}
}

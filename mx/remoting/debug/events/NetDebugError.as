//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebug;

/**
  Generic internal (to NetDebug) error event
*/
class mx.remoting.debug.events.NetDebugError extends NetDebug {
	
	function NetDebugError(dataobj :Object) {
		super();
		eventType = "NetDebugError";
		error = dataobj;
	}
	
	public var error:Object;
}
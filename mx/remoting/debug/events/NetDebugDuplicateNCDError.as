//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  another NCD is already running
*/
class mx.remoting.debug.events.NetDebugDuplicateNCDError extends NetDebugNetConnection {
	
	function NetDebugDuplicateNCDError() {
		super();
		eventType = "Error";
		source = "NCD";
		message = "NCD_ALREADY_RUNNING";
	}
	
	public var source:String;
	public var message:String;
}


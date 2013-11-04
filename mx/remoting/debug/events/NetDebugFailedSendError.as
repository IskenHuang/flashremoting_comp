//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  failed to send event
*/
class mx.remoting.debug.events.NetDebugFailedSendError extends NetDebugNetConnection {
	
	function NetDebugFailedSendError(ev:Object) {
		super();
		eventType = "Error";
		source = "NCD";
		originalEvent = ev;
		message = "NCD_FAILED_TO_SEND_EVENT";
	}
	
	public var source:String;
	public var originalEvent:Object;
	public var message:String;
}

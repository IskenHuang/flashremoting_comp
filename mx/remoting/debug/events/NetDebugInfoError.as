//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  received an error that has an info object
*/
class mx.remoting.debug.events.NetDebugInfoError extends NetDebugNetConnection {
	
	function NetDebugInfoError(infoobj:Object, mes:String) {
		super();
		eventType = "Error";
		source = "NCD";
		info = infoobj;
		if (mes != null) {
			message = mes;
		}
	}
	
	public var source:String;
	public var info:Object;
	public var message:String;
}

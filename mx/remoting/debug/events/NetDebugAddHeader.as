//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection addHeader called event
*/
class mx.remoting.debug.events.NetDebugAddHeader extends NetDebugNetConnection {
	
	function NetDebugAddHeader(args:Array)	{
		super();
		eventType = "AddHeader";
		headerName = args[0];
		mustUnderstand = args[1];
		if (args[2] != null) {
			headerObject = args[2];
		}
	}
	
	public var headerName:String;
	public var mustUnderstand:Boolean;
	public var headerObject:Object;
}
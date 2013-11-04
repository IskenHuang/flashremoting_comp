//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.NetDebugNetConnection;

/**
  NetConnection connect called event
*/
class mx.remoting.debug.events.NetDebugConnect extends NetDebugNetConnection {
	
	function NetDebugConnect(args:Array)	{
		super();
		eventType = "Connect";
		connectString = args[0];
		if (args[1] != null) {
			userName = args[1];
		}
		if (args[2] != null) {
			password = args[2];
		}
	}
	
	public var password:String;
	public var userName:String;
	public var connectString:String;

}

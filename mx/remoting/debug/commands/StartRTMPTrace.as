//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.commands.Local;

/**
  command to request that realtime trace be started
*/
class mx.remoting.debug.commands.StartRTMPTrace extends Local {
	
	function StartRTMPTrace(cs:String) {
		super();
		var connectinfo:Object = new Object();
		connectinfo.connectstring = cs;
		connectinfo.url = _root._url;
		init("startRealTimeTrace", connectinfo);
	}
}
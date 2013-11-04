//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.commands.Local;

/**
  command to request that realtime client be added 
*/
class mx.remoting.debug.commands.AddRTMPClient extends Local {
	
	function AddRTMPClient(cs:String, cid:Number) {
		super();
		var connectinfo:Object = new Object();
		connectinfo.connectstring = cs;
		connectinfo.url = _root._url;
		connectinfo.clientid = cid;
		init("addRealTimeClient", connectinfo);
	}
}
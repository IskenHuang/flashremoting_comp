//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.commands.Local;

/**
  Command to update NetDebug configuration (i.e. affects new NetConnections)
*/
class mx.remoting.debug.commands.UpdateNetDebugConfig extends Local {
	
	/**
	  Configures netdebug with the specified data
	  
	  @param	dataobj Object containing the appropriate configuration information
	*/
	function UpdateNetDebugCommand(dataobj:Object) {
		super();
		init("updateConfig", dataobj);
	}
}

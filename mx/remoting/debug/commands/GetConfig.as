//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.commands.Local;

/**
  command to request new a configuration
*/
class mx.remoting.debug.commands.GetConfig extends Local {
	
	function GetConfigCommand()	{
		super();
		init("getConfig", null);
	}
}

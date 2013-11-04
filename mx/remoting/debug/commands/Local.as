//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

/**
  Base class for some local commands
*/
class mx.remoting.debug.commands.Local extends Object {
	
	function Local()	{
		super();
	}
	
	function init(commandname:String, dataobj:Object):Void {
		command = commandname;
		data = dataobj;
	}
	
	public var command:String;
	public var data:Object;
}
//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.*;

/**
  proxy class to take the place of NetResponse object in NetConnection calls
*/
class mx.remoting.debug.NetDebugResponseProxy extends Object {
	
	function NetDebugResponseProxy(source:Object, original:Object) {
		super();
		// save our source for client events
		_sourceNC = source;
		// save the user's result object to forward results and errors
		_originalNR = original;
	}
	
	// our server-called events
	function onDebugEvents(debugevents:Array ):Void {
		var delen:Number = debugevents.length;
		for (var i:Number = 0; i < delen; i++) {
			_sourceNC.sendServerEvent(debugevents[i]);
		}
	}
	
	// NetResponse server-called events
	function onResult(resultobj:Object):Void {
		_sourceNC.sendClientEvent(new NetDebugResult(resultobj));
		_originalNR.onResult(resultobj);
	}
	
	function onStatus(statusobj:Object):Void {
		_sourceNC.sendClientEvent(new NetDebugStatus(statusobj));
		if (_originalNR.onStatus != undefined) {
			_originalNR.onStatus(statusobj);
		} 
		else {
			// ? do we need to call this here ?
			// or just forget about it because there was no onStatus
			// in the target NetResponse object
			_global.System.onStatus(statusobj);
		}
	}
	
	function __resolve(name:String):Function {
		trace("NetDebugResponseProxy.__resolve name: " + name);
		_sourceNC.sendClientEvent(new NetDebugReceiveCall(name, arguments));
		_originalNR[name].apply(arguments);
		return( null );
	}
	
	private var _sourceNC:Object;
	private var _originalNR:Object;
}
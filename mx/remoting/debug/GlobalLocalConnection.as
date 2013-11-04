//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.events.*;

/**
  a dual use class for sending or receiving data and commands 
  on a LocalConnection, using a global instance
*/
class mx.remoting.debug.GlobalLocalConnection extends Object {
	
	function GlobalLocalConnection(isController:Boolean, receiver:Object, domainName:String) {
		maxConnections = 10;
		var sToMovie 		= "_NetDebugLocalToDebugMovie";
		var sToController 	= "_NetDebugLocalToController";
	
		// set up the connection and send names
		var connectname = null;
		if (isController) {
			connectname = sToController;
			sendNames = new Array();
			sendNames.push(sToMovie);
			for (var i:Number = 0; i < maxConnections; i++) {
				sendNames.push(sToMovie + i);
			}
			maxConnections = 0;
		} 
		else {
			connectname = sToMovie;
			sendNames = new Array();
			sendNames.push(sToController);
		}
		setDomainName(domainName);
		// create LC as necessary
		if (_global.g_NetDebugLocalConnection == undefined) {
			_global.g_NetDebugLocalConnection = new LocalConnection();
			_global.g_NetDebugLocalConnection.allowDomain = function() {
				// allow everbody to send to us
				return true;
			}
		}
		if (receiver != null) {
			_global.g_NetDebugLocalConnection.m_Receiver = receiver;
			_global.g_NetDebugLocalConnection.onData = function(dataobj:Object):Void {
				_global.g_NetDebugLocalConnection.m_Receiver.onReceive(dataobj);
			}
			_global.g_NetDebugLocalConnection.onCommand = function(commandobj:Object):Void {
				_global.g_NetDebugLocalConnection.m_Receiver.onReceiveCommand(commandobj);
			}
			// now just connect
			if (!_global.g_NetDebugLocalConnection.connect(connectname)) {	
				var connected = false;
				for (var i:Number = 0; i < maxConnections; i++) {
					if (_global.g_NetDebugLocalConnection.connect(connectname + i)) {
						// got a connection
						connected = true;
						break;
					}
				}
				if (!connected) {
					if (isController) {		
						receiver.onReceiveError(new NetDebugDuplicateNCDError());
					} else {
						// can't report error in test movie
						//trace("NetDebug, over maximum number of movies");
					}
				} 
			}
		}
	}
	
	function setDomainName(domainName:String):Void	{
		if (domainName != null && domainName != "") {
			sendPrefix = domainName + ":";
		} else {
			sendPrefix = "";
		}
	}
	
	function send(dataobj:Object):Boolean {
		return( sendRaw("onData", dataobj));
	}
	
	function sendCommand(commandObj:Object):Boolean	{
		return( sendRaw("onCommand", commandObj));
	}
	
	function sendRaw(functionName:String, obj:Object):Boolean {
		var suc:Boolean = true;
		var snlen:Number = sendNames.length;
		for (var i:Number = 0; i < snlen; i++) 	
			suc = Boolean(suc & _global.g_NetDebugLocalConnection.send( sendPrefix + sendNames[i], functionName, obj));
		return( suc );
	}
	
	private var maxConnections:Number;
	private var sendNames:Array;
	private var sendPrefix:String;
}




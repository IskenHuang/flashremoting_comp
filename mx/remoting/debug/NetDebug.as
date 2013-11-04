//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

import mx.remoting.debug.GlobalLocalConnection;
import mx.remoting.debug.commands.GetConfig;
import mx.remoting.debug.NetDebugConfig;
import mx.remoting.debug.events.*;

/**
  The NetDebug object lets developers trace function calls, parameters, and results among the 
  Flash application, Flash Remoting, and the application server. The NetConnection Debugger 
  (NCD) panel in the Flash authoring environment can be used to view the debugging results. 

   @tiptext	Provides trace functionality for display in the NetConnection Debugger
   @helpid	4486
*/
class mx.remoting.debug.NetDebug extends Object {
	
	#include "..\RemotingComponentVersion.as"
	
	//constructor	
	function NetDebug() 
	{
		super();
		_ncs = new Array();
		_config = NetDebugConfig.getDefaultNetDebugConfig(false);
		_glc = new GlobalLocalConnection(false, this);
		// request a new config
		_glc.sendCommand(new GetConfig());
		_nextNewId = 0;
		// check if there is a handler assigned for System
		if (_global.System.onStatus == undefined)
			_global.System.onStatus = globalOnStatus;
		// mixin trace for on NetServices
		mx.remoting.NetServices.traceNetServices = traceNetServices;
	}

	/*
		Method. Adds a connection to an array. The array maintains the number of existing 
		connections created, when debugging	is supported in Applications.
		
		@param		nc		NetConnection Object The connection to be added to the array
		@return		Number	The number of connections in the array
	*/
	function addNetConnection(nc:NetConnection):Number {
		_ncs.push(nc);
		return( _nextNewId++ );
	}

	/*
		Creates a default debug config and returns a Boolean if creation is successful.

		@return		Boolean	returns true if the debug config is created successfully
	*/
	function requestNewConfig():Boolean	
	{
		return(sendCommand(new GetConfig()));
	}

	/*
		Removes the specified connection from the connection array maintained by NetDebug. 

		@param		nc	NetConnection	name of the connection to be removed
		@return		nothing
	*/
	function removeNetConnection(nc:NetConnection):Void 
	{
		var ncslen:Number = _ncs.length;
		for (var i:Number = 0; i < ncslen; i++) {
			if (nc == _ncs[i]) {
				_ncs.splice(i, 1);
				break;
			}
		}
	}
	
	/*
		If the event fired is sent successfuly, a Boolean value (true) is returned

		@param	eventObj	Object the object containing information about the event
		@return	Boolean	returns	true if the event is sent successfully, else false
	*/
	function sendDebugEvent(eventobj:Object):Boolean 
	{
		if (!_glc.send(eventobj)) 
		{
			// the event failed to send, create an error event in its place
			_glc.send(new NetDebugFailedSendError(stripNCDEventToMinmal(eventobj)));
			return( false );
		}
		return( true );
	}

	
	function sendCommand(commandobj):Boolean 
	{
		return( _glc.sendCommand(commandobj));
	}

	/*
		Updates the config of the existing connections maintained in the connection 
		array with new configuration specified. 

		@param		config Object the configuration to be updated for connections
		@return		nothing
	*/
	function updateConfig(config:Object):Void {
		// merge our default config and all our ncs
		mx.utils.ObjectCopy.copyProperties(_config, config);
		var ncslen:Number = _ncs.length;
		for (var i:Number = 0; i < ncslen; i++) {
			if (_ncs[i] != null) {
				_ncs[i].updateConfig(config);
			}
		}
	}
	

	function sendStatus(statusobj:Object):Boolean 
	{
		if (_config.m_debug && _config.client.m_debug)
			return( _glc.send(new NetDebugStatus(statusobj)));
	}

	/*
		When an event is sent successfully to the Connection Debugger, an Event handler is invoked 

		@param	eventObj	Object	containing the event information
		@return	Boolean		returns true if the event is sent successfully
	*/ 
	function onEvent(eventObj:Object):Boolean {
		return( sendDebugEvent(eventObj));
	}
	
	/*
		When an event fails to send to the Connection Debugger, an Error Event 
		handler is invoked

		@param		errorObj	eventObj Object containing the error event information
		@return		Boolean
	*/ 
	function onEventError(errorObj:Object):Boolean 
	{
		return( sendDebugEvent(new NetDebugError(errorObj)));
	}

	/* 
		 When a command is received, onRecieveCommand is invoked. This calls the 
		 function specified in the commandObj parameter on "this" object 

		 @param		commandObj	Object	The object containing the name of the function and data
	*/
	function onReceiveCommand(commandobj:Object):Void {
		this[commandobj.command](commandobj.data);
	}
	
	/*
		 When an error is received, onRecieveError is invoked. This calls the function 
		 specified in the errorObj parameter on "this" object 

		 @param		errorObj	Object	The object containing the name of the function and data
	*/
	function onReceiveError(errorobj:Object):Void {
		sendDebugEvent(new NetDebugError(errorobj));
	}

	/*
		Retrieves the NetConnection object's debug subscribed events.
		
		@return		NetDebugConfig object containing configuration information
	*/
	function getConfig():NetDebugConfig 
	{
		return( _config );
	}
	
	// static members --------------------------------------------------
	/*
		Returns an already created NetDebug Object

		@return		NetDebug Object
	*/
	public static function getNetDebug():mx.remoting.debug.NetDebug 
	{
		return( ndSingleton );
	}
	
	/**
		Sends a serializable ActionScript object as a client trace event 
		to the Connection Debugger. This trace event does not include 
		connection information. 

		@param		Object	The Actionscript Object which is sent to the Debugger
		@tiptext	Sends the contents of the specified object to the NetConnection Debugger
		@helpid	4487
	*/
	public static function trace(obj:Object):Void {
		getNetDebug()._trace(obj);
	}

	/*
		Sends a customised message to the Connection Debugger.

		@param		String	who
		@param		String	severity
		@param		Number	number
		@param		String	message
	*/
	public static function traceNetServices(who:String, severity:String, number:Number, message:String):Void {
		getNetDebug()._traceNetServices(who, severity, number, message);
	}

	public static function globalOnStatus(statusobj:Object):Void {
		getNetDebug().sendStatus(statusobj);
	}
	
	/**
		Initializes debugging, which allows all remoting information to be sent to
		the NetConnection Debugger. This creates a new default debug configuration 
		for all debugging information that is trasmitted to the NetConnection Debugger 

		@return		Boolean	returns true
		@tiptext	Initializes debugging
		@helpid	4488
	*/
	public static function initialize():Boolean {
		if( ndSingleton == null )  {
			ndSingleton = new mx.remoting.debug.NetDebug();
			mx.remoting.debug.ConnectionMixin.initialize();
		}
		return( true );
	}
	
	/* 
		Accepts an Object as a parameter and returns its minimal atrributes in a new Object.
		The attributs are source, movieUrl, date, time, protocol, debugId 

		@param		ev	Object	The event object from which information is to be retrieved
		@return		Object	A new Event Object
		@tiptext	Returns a new EventObject with minimal attributes of given EventObject
	*/
	public static function stripNCDEventToMinmal(ev:Object):Object {
		var ret:Object = new Object();
		if (ev.eventType != null) 
			ret.eventType = ev.eventType;
			
		if (ev.source != null) 
			ret.source = ev.source;
			
		if (ev.movieUrl	!= null) 
			ret.movieUrl = ev.movieUrl;
			
		if (ev.date != null) 
			ret.date = ev.date;
			
		if (ev.time	!= null) 
			ret.time = ev.time;
			
		if (ev.protocol	!= null) 
			ret.protocol = ev.protocol;
			
		if (ev.debugId != null)
			ret.debugId	= ev.debugId;
		return( ret );
	}
	
	private function _traceNetServices(who:String, severity:String, number:Number, message:String):Void {	
		if( _config.m_debug && _config.client.m_debug && _config.client.trace ) {
			if(!sendDebugEvent(new NetDebugTraceNetServices(who, severity, number, message))) {
				// can't report error in test movie
				//trace("NetDebug.trace - Failed to sendDebugEvent");	
			}
		}
	}


	private function _trace(traceobj:Object):Void {	
		if (_config.m_debug && _config.client.m_debug && _config.client.trace) {
			if (!sendDebugEvent(new NetDebugTrace(traceobj))) {
				// can't report error in test movie
				//trace("NetDebug.trace - Failed to sendDebugEvent");	
			}
		}
	}


	
	private static var ndSingleton:mx.remoting.debug.NetDebug;
	
	private var _ncs:Array;
	private var _config:NetDebugConfig;
	private var _glc:GlobalLocalConnection;
	private var _nextNewId:Number;
}
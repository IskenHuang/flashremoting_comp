//****************************************************************************
//Copyright (C) 2004 Macromedia, Inc. All Rights Reserved.
//The following is Sample Code and is subject to all restrictions on
//such code as contained in the End User License Agreement accompanying
//this product.
//****************************************************************************

// register this class so class gets recontructed with functions after serialization
//Object.registerClass("NetDebugConfig", NetDebugConfig);

class mx.remoting.debug.NetDebugConfig extends Object {

	function NetDebugConfig() {
		super();
		Object.registerClass( "NetDebugConfig", mx.remoting.debug.NetDebugConfig );
	//	attachNetDebugConfigFunctions(this);
	}

 	public static function getNetDebugVersion():Number {
		return( 1 );
	}

	public static function attachNetDebugConfigFunctions(ndc:Object):Object {
		
		ndc.setDebug = function(setval:Boolean) {
			this.m_debug = setval;
		}
		
		ndc.getDebug = function():Boolean {
			return this.m_debug;
		}
		
		for (var prop in ndc) {
			if (typeof(ndc[prop]) == "object") {
				attachNetDebugConfigFunctions(ndc[prop]);
			}
		}

        return null;
	}

	public static function getDefaultNetDebugConfig(isController:Boolean):NetDebugConfig {
		if (_global.netDebugConfigSO == undefined) {
			var soName = "TestMovie_Config_Info";
			if (isController) {
				soName = "Controller_Config_Info";
			}
			_global.netDebugConfigSO = SharedObject.getLocal(soName);
		}
		
		if (_global.netDebugConfigSO.data.config == undefined) {
			_global.netDebugConfigSO.data.config = getRealDefaultNetDebugConfig();
		}
		
		_global.netDebugConfigSO.flush();
	//	attachNetDebugConfigFunctions(_global.netDebugConfigSO.data.config);
		return( _global.netDebugConfigSO.data.config );
	}

	public static function getRealDefaultNetDebugConfig():NetDebugConfig {
		var defaultConfig = new NetDebugConfig();
		defaultConfig.m_debug = true;
		// client
		defaultConfig.client = new NetDebugConfig();
		defaultConfig.client.m_debug = true;
		defaultConfig.client.trace = true;
		defaultConfig.client.recordset = true;
		defaultConfig.client.http = true;
		defaultConfig.client.rtmp = true;
		// realtime server
		defaultConfig.realtime_server = new NetDebugConfig();
		defaultConfig.realtime_server.m_debug = true;
		defaultConfig.realtime_server.trace	= true;
		// app server
		defaultConfig.app_server = new NetDebugConfig();
		defaultConfig.app_server.m_debug	= true;
		defaultConfig.app_server.trace = true;
		defaultConfig.app_server.error = true;
		defaultConfig.app_server.recordset = true;
		defaultConfig.app_server.httpheaders = false;
		defaultConfig.app_server.amf = false;
		defaultConfig.app_server.amfheaders = false;
		// ColdFusion
		defaultConfig.app_server.coldfusion = true;
		return( defaultConfig );
	}
	
	public var m_debug:Boolean;
	// client
	public var client:NetDebugConfig;
	public var trace:Boolean;
	public var recordset:Boolean;
	public var http:Boolean;
	public var rtmp:Boolean;
	// realtime server
	public var realtime_server:NetDebugConfig;
	// app server
	public var app_server:NetDebugConfig;
	public var error:Boolean;
	public var httpheaders:Boolean;
	public var amf:Boolean;
	public var amfheaders:Boolean;
	// ColdFusion
	public var coldfusion:Boolean;
}
package com.sulake.core.assets.loaders
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.ByteArray;
    import flash.net.URLRequest;

    public /*dynamic*/ interface IAssetLoader extends IEventDispatcher, IDisposable 
    {

        function get url():String;
        function get content():Object;
        function get bytes():ByteArray;
        function get mimeType():String;
        function get bytesLoaded():uint;
        function get bytesTotal():uint;
        function get errorCode():uint;
        function get cacheKey():String;
        function get cacheRevision():String;
        function get fromCache():Boolean;
        function get id():int;
        function load(_arg_1:URLRequest):void;

    }
}
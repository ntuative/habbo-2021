package com.sulake.core.assets.loaders
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import com.sulake.core.runtime.IDisposable;
    import flash.events.HTTPStatusEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.events.Event;

    internal class _SafeStr_16 extends EventDispatcherWrapper implements IDisposable 
    {

        public static const _SafeStr_617:uint = 0;
        public static const IO_ERROR:uint = 1;
        public static const _SafeStr_775:uint = 2;

        protected var _status:int = 0;
        protected var _SafeStr_777:int = 0;
        protected var _SafeStr_778:int = 2;
        protected var _SafeStr_776:uint = 0;


        public function get errorCode():uint
        {
            return (_SafeStr_776);
        }

        protected function loadEventHandler(_arg_1:Event):void
        {
            switch (_arg_1.type)
            {
                case "httpStatus":
                    _status = HTTPStatusEvent(_arg_1).status;
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventStatus", _status));
                    return;
                case "complete":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventComplete", _status));
                    return;
                case "unload":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventUnload", _status));
                    return;
                case "open":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventOpen", _status));
                    return;
                case "progress":
                    dispatchEvent(new AssetLoaderEvent("AssetLoaderEventProgress", _status));
                    return;
                case "ioError":
                    _SafeStr_776 = 1;
                    if (!retry())
                    {
                        dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError", _status));
                    };
                    return;
                case "securityError":
                    _SafeStr_776 = 2;
                    if (!retry())
                    {
                        dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError", _status));
                    };
                    return;
                default:
                    return;
            };
        }

        protected function retry():Boolean
        {
            return (false);
        }


    }
}


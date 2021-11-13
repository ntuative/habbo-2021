package com.sulake.habbo.communication
{
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;

    public class ApiRequest 
    {

        public static const ERROR_TYPE_INVALID_CAPTCHA:String = "invalid-captcha";

        private var _SafeStr_447:IApiListener;
        private var _SafeStr_2121:URLRequest;
        private var _uri:String;
        private var _requestMethod:String;
        private var _currentStatus:int;

        public function ApiRequest(_arg_1:String, _arg_2:String)
        {
            _uri = _arg_2;
            _requestMethod = _arg_1;
        }

        public function get uri():String
        {
            return (_uri);
        }

        public function get requestMethod():String
        {
            return (_requestMethod);
        }

        public function dispose():void
        {
            _SafeStr_447 = null;
            _SafeStr_2121 = null;
            _uri = null;
            _requestMethod = null;
            _currentStatus = 0;
        }

        public function makeRequest(_arg_1:IApiListener, _arg_2:URLRequest):void
        {
            _arg_2.method = _requestMethod;
            _SafeStr_2121 = _arg_2;
            _SafeStr_447 = _arg_1;
            var _local_3:URLLoader = new URLLoader();
            _local_3.dataFormat = "text";
            configureListeners(_local_3);
            try
            {
                Logger.log(((("[ApiRequest] Make request: " + _arg_2.url) + " for ") + _uri));
                _local_3.load(_arg_2);
            }
            catch(error:Error)
            {
                Logger.log("[ApiRequest] Unable to load requested document.");
            };
        }

        private function configureListeners(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener("complete", completeHandler);
            _arg_1.addEventListener("open", openHandler);
            _arg_1.addEventListener("progress", progressHandler);
            _arg_1.addEventListener("securityError", securityErrorHandler);
            _arg_1.addEventListener("httpStatus", httpStatusHandler);
            _arg_1.addEventListener("ioError", ioErrorHandler);
        }

        private function removeListeners(_arg_1:IEventDispatcher):void
        {
            _arg_1.removeEventListener("complete", completeHandler);
            _arg_1.removeEventListener("open", openHandler);
            _arg_1.removeEventListener("progress", progressHandler);
            _arg_1.removeEventListener("securityError", securityErrorHandler);
            _arg_1.removeEventListener("httpStatus", httpStatusHandler);
            _arg_1.removeEventListener("ioError", ioErrorHandler);
        }

        private function completeHandler(_arg_1:Event):void
        {
            var _local_5:String;
            var _local_6:Boolean;
            var _local_2:Boolean;
            var _local_3:Object;
            var _local_7:Boolean;
            var _local_4:URLLoader = URLLoader(_arg_1.target);
            removeListeners(_local_4);
            if (_SafeStr_447)
            {
                _local_5 = (_local_4.data as String);
                _local_6 = ((_local_5) && ((_local_5.charAt(0) == "{") || (_local_5.charAt(0) == "[")));
                _local_2 = ((_local_5) && (_local_5.charAt(0) == "<"));
                try
                {
                    if (_local_6)
                    {
                        _local_3 = JSON.parse(_local_5);
                    }
                    else
                    {
                        if (_local_2)
                        {
                            _local_3 = new XML(_local_5);
                        };
                    };
                    if (((_currentStatus >= 400) || ((_local_6) && (!(_local_3.error == null)))))
                    {
                        _local_7 = false;
                        if (_local_6)
                        {
                            _local_7 = ((_local_3.error == "invalid-captcha") || (_local_3.message == "invalid-captcha"));
                        };
                        _SafeStr_447.apiError(_uri, _currentStatus, ((_local_6) ? _local_3.error : ""), _local_3, _local_7);
                    }
                    else
                    {
                        _SafeStr_447.apiResponse(_uri, _local_3);
                    };
                }
                catch(e:Error)
                {
                    Logger.log(((("JSON parsing for API Request message failed. Data: " + _local_4.data) + " Error: ") + e.errorID), e.name, e.message, e.getStackTrace());
                    _SafeStr_447.apiRawResponse(_uri, _local_4.data);
                };
            };
        }

        private function openHandler(_arg_1:Event):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
        }

        private function progressHandler(_arg_1:ProgressEvent):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
        }

        private function securityErrorHandler(_arg_1:SecurityErrorEvent):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            Logger.log(("[ApiRequest] securityErrorHandler: " + _arg_1));
            if (_SafeStr_447 != null)
            {
                _SafeStr_447.apiError(_uri, -1, "securityError", null);
            };
            removeListeners(_local_2);
        }

        private function httpStatusHandler(_arg_1:HTTPStatusEvent):void
        {
            var _local_2:URLLoader = URLLoader(_arg_1.target);
            _currentStatus = _arg_1.status;
            switch (_arg_1.status)
            {
                case 200:
                    return;
                case 403:
                    return;
                case 404:
                    Logger.log(("[ApiRequest - 404] httpStatusHandler: Resource does not exist. " + _uri), _requestMethod, _SafeStr_2121.url);
                    return;
                case 409:
                    Logger.log(("[ApiRequest - 409] httpStatusHandler: Conflict. " + _uri), _requestMethod, _SafeStr_2121.url, _local_2);
                    return;
                case 500:
                    Logger.log(("[ApiRequest - 500] httpStatusHandler: Internal server error. " + _uri), _requestMethod, _local_2);
                    return;
                default:
                    Logger.log(((("[ApiRequest - " + _arg_1.status) + "] httpStatusHandler: undhandled. ") + _uri), _requestMethod, _SafeStr_2121.url);
                    return;
            };
        }

        private function ioErrorHandler(_arg_1:IOErrorEvent):void
        {
            var _local_3:Object;
            var _local_4:Boolean;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_2:Boolean;
            var _local_5:URLLoader = URLLoader(_arg_1.target);
            removeListeners(_local_5);
            if (_SafeStr_447 != null)
            {
                _local_3 = {"message":_local_5.data};
                _local_4 = false;
                if (_local_5.data)
                {
                    try
                    {
                        _local_6 = _local_5.data;
                        _local_7 = ((_local_6) && ((_local_6.charAt(0) == "{") || (_local_6.charAt(0) == "[")));
                        _local_2 = ((_local_6) && (_local_6.charAt(0) == "<"));
                        _local_3 = ((_local_7) ? JSON.parse(_local_5.data) : _local_5.data);
                        if (_local_7)
                        {
                            if (((!(_local_3.captcha == null)) && (_local_3.captcha is Boolean)))
                            {
                                _local_4 = _local_3.captcha;
                            };
                        };
                    }
                    catch(e:Error)
                    {
                        Logger.log(("JSON parsing for Api Request ioError. Data: " + _local_5.data));
                    };
                };
                _SafeStr_447.apiError(_uri, -2, "ioError", _local_3, _local_4);
            };
        }


    }
}


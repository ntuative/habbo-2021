package com.sulake.core.utils
{
    public class BrowserInfo 
    {

        public static const _SafeStr_864:String = "win";
        public static const MAC_PLATFORM:String = "mac";
        public static const SAFARI_AGENT:String = "safari";
        public static const _SafeStr_865:String = "opera";
        public static const IE_AGENT:String = "msie";
        public static const MOZILLA_AGENT:String = "mozilla";
        public static const CHROME_AGENT:String = "chrome";

        private var _platform:String = "undefined";
        private var _browser:String = "undefined";
        private var _version:String = "undefined";

        public function BrowserInfo(_arg_1:Object, _arg_2:Object, _arg_3:String)
        {
            if ((((!(_arg_1)) || (!(_arg_2))) || (!(_arg_3))))
            {
                return;
            };
            _version = _arg_1.version;
            for (var _local_5:String in _arg_1)
            {
                if (_local_5 != "version")
                {
                    if (_arg_1[_local_5] == true)
                    {
                        _browser = _local_5;
                        break;
                    };
                };
            };
            for (var _local_4:String in _arg_2)
            {
                if (_arg_2[_local_4] == true)
                {
                    _platform = _local_4;
                };
            };
        }

        public function get platform():String
        {
            return (_platform);
        }

        public function get browser():String
        {
            return (_browser);
        }

        public function get version():String
        {
            return (_version);
        }


    }
}


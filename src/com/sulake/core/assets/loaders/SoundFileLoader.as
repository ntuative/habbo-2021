package com.sulake.core.assets.loaders
{
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;

    public class SoundFileLoader extends _SafeStr_16 implements IAssetLoader 
    {

        protected var _SafeStr_780:String;
        protected var _SafeStr_741:String;
        protected var _SafeStr_784:Sound;
        private var _cacheKey:String;
        private var _cacheRevision:String;
        private var _fromCache:Boolean = false;
        private var _id:int;

        public function SoundFileLoader(_arg_1:String, _arg_2:URLRequest=null, _arg_3:String=null, _arg_4:String=null, _arg_5:ByteArray=null, _arg_6:int=-1)
        {
            _SafeStr_780 = ((_arg_2 == null) ? "" : _arg_2.url);
            _SafeStr_741 = _arg_1;
            _SafeStr_784 = new Sound(null, null);
            _SafeStr_784.addEventListener("id3", loadEventHandler);
            _SafeStr_784.addEventListener("open", loadEventHandler);
            _SafeStr_784.addEventListener("complete", loadEventHandler);
            _SafeStr_784.addEventListener("ioError", loadEventHandler);
            _SafeStr_784.addEventListener("progress", loadEventHandler);
            _cacheKey = _arg_3;
            _cacheRevision = _arg_4;
            _id = _arg_6;
            if (((!(_arg_5 == null)) && (_arg_5.length > 0)))
            {
                _fromCache = true;
                _SafeStr_784.loadPCMFromByteArray(_arg_5, _arg_5.length);
            }
            else
            {
                if (_arg_2 != null)
                {
                    this.load(_arg_2);
                };
            };
        }

        public function get url():String
        {
            return (_SafeStr_780);
        }

        public function get content():Object
        {
            return (_SafeStr_784);
        }

        public function get bytes():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _SafeStr_784.extract(_local_1, _SafeStr_784.length);
            return (_local_1);
        }

        public function get mimeType():String
        {
            return (_SafeStr_741);
        }

        public function get bytesLoaded():uint
        {
            return ((_SafeStr_784) ? _SafeStr_784.bytesLoaded : 0);
        }

        public function get bytesTotal():uint
        {
            return ((_SafeStr_784) ? _SafeStr_784.bytesTotal : 0);
        }

        public function get cacheKey():String
        {
            return (_cacheKey);
        }

        public function get cacheRevision():String
        {
            return (_cacheRevision);
        }

        public function get fromCache():Boolean
        {
            return (_fromCache);
        }

        public function get id():int
        {
            return (_id);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _SafeStr_784.removeEventListener("id3", loadEventHandler);
                _SafeStr_784.removeEventListener("open", loadEventHandler);
                _SafeStr_784.removeEventListener("complete", loadEventHandler);
                _SafeStr_784.removeEventListener("ioError", loadEventHandler);
                _SafeStr_784.removeEventListener("progress", loadEventHandler);
                _SafeStr_784 = null;
                _SafeStr_741 = null;
                _SafeStr_780 = null;
                super.dispose();
            };
        }

        public function load(_arg_1:URLRequest):void
        {
            _SafeStr_780 = _arg_1.url;
            _SafeStr_784.load(_arg_1, null);
        }


    }
}


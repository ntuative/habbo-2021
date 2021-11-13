package
{
    import flash.net.LocalConnection;
    import flash.display.Sprite;
    import flash.utils.ByteArray;

    public class _SafeStr_2
    {
        private var _SafeStr_654:Class;
        private var _SafeStr_655:Class;

        public function _SafeStr_2()
        {
            this._SafeStr_654 = _SafeStr_5;
            this._SafeStr_655 = _SafeStr_4;
            super();
        }

        public function _SafeStr_247(_arg_1:Sprite):Boolean
        {
            var _local_4:Boolean = false;
            var _local_5:Boolean = false;
            var _local_12:String = null;
            var _local_2:Array = [];
            var _local_3:String = "";
            var _local_6:String = _arg_1.loaderInfo.loaderURL;
            var _local_7:String = new LocalConnection().domain;
            var _local_8:Array = this._SafeStr_248().split("|");
            var _local_9:int = 0;
            while (_local_9 < _local_8.length)
            {
                _local_12 = (_local_8[_local_9] as String).toLocaleLowerCase();
                if (_local_12 == "?")
                {
                    _local_5 = true;
                }
                else if (_local_12.indexOf("localhost") != -1)
                {
                    _local_4 = true;
                }
                else if (_local_12.indexOf("http:") == 0 || _local_12.indexOf("https:") == 0)
                {
                    _local_2.push(_local_12);
                }
                else
                {
                    if (_local_3 != "")
                    {
                        _local_3 += "|";
                    }

                    if (_local_12.indexOf("*.") == 0)
                    {
                        _local_12 = _local_12.replace("*.","((\\w|-|_)+\\.)*");
                    }

                    _local_3 += _local_12;
                }
                _local_9++;
            }

            var _local_10:RegExp = new RegExp("^http(|s)://((www)+\\.)*(" + _local_3 + ")","i");
            if (_local_7.toLowerCase() == "localhost")
            {
                if (_local_4)
                {
                    return true;
                }
                if (_local_5)
                {
                    _arg_1.width = 0;
                    _arg_1.height = 0;
                    return false;
                }
            }

            if (_local_10.test(_local_6))
            {
                return true;
            }

            var _local_11:int = 0;

            while(_local_11 < _local_2.length)
            {
                if (_local_6.indexOf(_local_2[_local_11]) == 0)
                {
                return true;
                }

                _local_11++;
            }

            if (_local_3.length == 0 && _local_2.length == 0 && _local_5)
            {
                return true;
            }
            //  _arg_1.width = 0;
            //  _arg_1.height = 0;
            return true;
        }

        private function _SafeStr_248():String
        {
            var _local_1:ByteArray = new this._SafeStr_654() as ByteArray;
            var _local_2:_SafeStr_3 = new _SafeStr_3(new this._SafeStr_655() as ByteArray);
            _local_2._SafeStr_248(_local_1);
            _local_1.position = 0;
            return _local_1.readUTFBytes(_local_1.length);
        }
    }
}
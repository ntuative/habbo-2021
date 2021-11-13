package com.sulake.core.assets.loaders
{
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import com.probertson.utils._SafeStr_40;
    import flash.errors.IllegalOperationError;

    public class TextFileLoader extends BinaryFileLoader implements IAssetLoader 
    {

        public function TextFileLoader(_arg_1:String, _arg_2:URLRequest=null, _arg_3:String=null, _arg_4:String=null, _arg_5:ByteArray=null, _arg_6:int=-1)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        override protected function retry():Boolean
        {
            if (!_disposed)
            {
                if (++_SafeStr_777 <= _SafeStr_778)
                {
                    try
                    {
                        _SafeStr_779.close();
                    }
                    catch(e:Error)
                    {
                    };
                    _SafeStr_779.load(new URLRequest((((_SafeStr_780 + ((_SafeStr_780.indexOf("?") == -1) ? "?" : "&")) + "retry=") + _SafeStr_777)));
                    return (true);
                };
            };
            return (false);
        }

        override protected function loadEventHandler(_arg_1:Event):void
        {
            if (_arg_1.type == "complete")
            {
                unCompress();
            };
            super.loadEventHandler(_arg_1);
        }

        private function unCompress():void
        {
            var _local_2:ByteArray;
            var _local_3:_SafeStr_40;
            var _local_1:String = "";
            if ((_SafeStr_779.data is ByteArray))
            {
                _local_2 = (_SafeStr_779.data as ByteArray);
                if (_local_2.length == 0)
                {
                    _local_1 = "";
                }
                else
                {
                    try
                    {
                        _local_3 = new _SafeStr_40();
                        _local_1 = _local_3.uncompressToByteArray(_local_2).toString();
                    }
                    catch(error:IllegalOperationError)
                    {
                        _local_2.position = 0;
                        _local_1 = _local_2.readUTFBytes(_local_2.length);
                    };
                };
                _local_2.position = 0;
            }
            else
            {
                _local_1 = (_SafeStr_779.data as String);
            };
            _SafeStr_779.data = _local_1;
        }


    }
}


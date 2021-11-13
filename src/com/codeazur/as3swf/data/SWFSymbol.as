package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFSymbol 
    {

        public var _SafeStr_266:uint;
        public var name:String;

        public function SWFSymbol(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public static function create(_arg_1:uint, _arg_2:String):SWFSymbol
        {
            var _local_3:SWFSymbol = new SWFSymbol();
            _local_3._SafeStr_266 = _arg_1;
            _local_3.name = _arg_2;
            return (_local_3);
        }


        public function parse(_arg_1:SWFData):void
        {
            _SafeStr_266 = _arg_1.readUI16();
            name = _arg_1.readString();
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeUI16(_SafeStr_266);
            _arg_1.writeString(name);
        }

        public function toString():String
        {
            return ((("TagID: " + _SafeStr_266) + ", Name: ") + name);
        }


    }
}


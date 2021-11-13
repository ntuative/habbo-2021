package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagDoABC implements ITag 
    {

        public static const TYPE:uint = 82;

        public var _SafeStr_389:Boolean;
        public var abcName:String = "";
        protected var _SafeStr_736:ByteArray;

        public function TagDoABC()
        {
            _SafeStr_736 = new ByteArray();
        }

        public static function create(_arg_1:ByteArray=null, _arg_2:String="", _arg_3:Boolean=true):TagDoABC
        {
            var _local_4:TagDoABC = new TagDoABC();
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _local_4.bytes.writeBytes(_arg_1);
            };
            _local_4.abcName = _arg_2;
            _local_4._SafeStr_389 = _arg_3;
            return (_local_4);
        }


        public function get bytes():ByteArray
        {
            return (_SafeStr_736);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.position;
            var _local_6:uint = _arg_1.readUI32();
            _SafeStr_389 = (!((_local_6 & 0x01) == 0));
            abcName = _arg_1.readString();
            _arg_1.readBytes(bytes, 0, (_arg_2 - (_arg_1.position - _local_5)));
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI32(((_SafeStr_389) ? 1 : 0));
            _local_3.writeString(abcName);
            if (_SafeStr_736.length > 0)
            {
                _local_3.writeBytes(_SafeStr_736);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (82);
        }

        public function get name():String
        {
            return ("DoABC");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Lazy: ") + _SafeStr_389) + ", ") + ((abcName.length > 0) ? (("Name: " + abcName) + ", ") : "")) + "Length: ") + _SafeStr_736.length);
        }


    }
}


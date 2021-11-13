package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagFrameLabel implements ITag 
    {

        public static const TYPE:uint = 43;

        public var frameName:String;
        public var _SafeStr_283:Boolean;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.position;
            frameName = _arg_1.readString();
            if ((_arg_1.position - _local_5) < _arg_2)
            {
                _arg_1.readUI8();
                _SafeStr_283 = true;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeString(frameName);
            if (_SafeStr_283)
            {
                _arg_1.writeUI8(1);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (43);
        }

        public function get name():String
        {
            return ("FrameLabel");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ("Name: " + frameName);
            if (_SafeStr_283)
            {
                _local_2 = (_local_2 + ", NamedAnchor = true");
            };
            return (_SafeStr_64.toStringCommon(type, name, _arg_1) + _local_2);
        }


    }
}


package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagEnableDebugger2 extends TagEnableDebugger implements ITag 
    {

        public static const TYPE:uint = 64;

        protected var _SafeStr_737:uint = 0;


        public function get reserved():uint
        {
            return (_SafeStr_737);
        }

        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_737 = _arg_1.readUI16();
            if (_arg_2 > 2)
            {
                _arg_1.readBytes(_SafeStr_600, 0, (_arg_2 - 2));
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, (_SafeStr_600.length + 2));
            _arg_1.writeUI16(_SafeStr_737);
            if (_SafeStr_600.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_600);
            };
        }

        override public function get type():uint
        {
            return (64);
        }

        override public function get name():String
        {
            return ("EnableDebugger2");
        }

        override public function get version():uint
        {
            return (6);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Password: ") + ((_SafeStr_600.length) ? "null" : _SafeStr_600.readUTF())) + ", ") + "Reserved: 0x") + _SafeStr_737.toString(16));
        }


    }
}


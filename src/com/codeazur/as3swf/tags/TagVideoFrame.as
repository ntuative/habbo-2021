package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;

    public class TagVideoFrame implements ITag 
    {

        public static const TYPE:uint = 61;

        public var _SafeStr_372:uint;
        public var _SafeStr_373:uint;
        protected var _SafeStr_742:ByteArray;

        public function TagVideoFrame()
        {
            _SafeStr_742 = new ByteArray();
        }

        public function get videoData():ByteArray
        {
            return (_SafeStr_742);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_372 = _arg_1.readUI16();
            _SafeStr_373 = _arg_1.readUI16();
            _arg_1.readBytes(_SafeStr_742, 0, (_arg_2 - 4));
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, (_SafeStr_742.length + 4));
            _arg_1.writeUI16(_SafeStr_372);
            _arg_1.writeUI16(_SafeStr_373);
            if (_SafeStr_742.length > 0)
            {
                _arg_1.writeBytes(_SafeStr_742);
            };
        }

        public function get type():uint
        {
            return (61);
        }

        public function get name():String
        {
            return ("VideoFrame");
        }

        public function get version():uint
        {
            return (6);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "StreamID: ") + _SafeStr_372) + ", ") + "Frame: ") + _SafeStr_373);
        }


    }
}


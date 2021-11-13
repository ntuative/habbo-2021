package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagCSMTextSettings implements ITag 
    {

        public static const TYPE:uint = 74;

        public var _SafeStr_348:uint;
        public var useFlashType:uint;
        public var _SafeStr_349:uint;
        public var thickness:Number;
        public var sharpness:Number;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_348 = _arg_1.readUI16();
            useFlashType = _arg_1.readUB(2);
            _SafeStr_349 = _arg_1.readUB(3);
            _arg_1.readUB(3);
            thickness = _arg_1.readFIXED();
            sharpness = _arg_1.readFIXED();
            _arg_1.readUI8();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 12);
            _arg_1.writeUI16(_SafeStr_348);
            _arg_1.writeUB(2, useFlashType);
            _arg_1.writeUB(3, _SafeStr_349);
            _arg_1.writeUB(3, 0);
            _arg_1.writeFIXED(thickness);
            _arg_1.writeFIXED(sharpness);
            _arg_1.writeUI8(0);
        }

        public function get type():uint
        {
            return (74);
        }

        public function get name():String
        {
            return ("CSMTextSettings");
        }

        public function get version():uint
        {
            return (8);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "TextID: ") + _SafeStr_348) + ", ") + "UseFlashType: ") + useFlashType) + ", ") + "GridFit: ") + _SafeStr_349) + ", ") + "Thickness: ") + thickness) + ", ") + "Sharpness: ") + sharpness);
        }


    }
}


package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.ColorUtils;

    public class TagSetBackgroundColor implements ITag 
    {

        public static const TYPE:uint = 9;

        public var color:uint = 0xFFFFFF;


        public static function create(_arg_1:uint=0xFFFFFF):TagSetBackgroundColor
        {
            var _local_2:TagSetBackgroundColor = new TagSetBackgroundColor();
            _local_2.color = _arg_1;
            return (_local_2);
        }


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            color = _arg_1.readRGB();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 3);
            _arg_1.writeRGB(color);
        }

        public function get type():uint
        {
            return (9);
        }

        public function get name():String
        {
            return ("SetBackgroundColor");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Color: ") + ColorUtils.rgbToString(color));
        }


    }
}


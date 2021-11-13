package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagRemoveObject2 extends TagRemoveObject implements _SafeStr_54 
    {

        public static const TYPE:uint = 28;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            depth = _arg_1.readUI16();
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 2);
            _arg_1.writeUI16(depth);
        }

        override public function get type():uint
        {
            return (28);
        }

        override public function get name():String
        {
            return ("RemoveObject2");
        }

        override public function get version():uint
        {
            return (3);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Depth: ") + depth);
        }


    }
}


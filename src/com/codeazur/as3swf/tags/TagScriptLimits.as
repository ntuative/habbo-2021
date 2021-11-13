package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagScriptLimits implements ITag 
    {

        public static const TYPE:uint = 65;

        public var maxRecursionDepth:uint;
        public var _SafeStr_376:uint;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            maxRecursionDepth = _arg_1.readUI16();
            _SafeStr_376 = _arg_1.readUI16();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 4);
            _arg_1.writeUI16(maxRecursionDepth);
            _arg_1.writeUI16(_SafeStr_376);
        }

        public function get type():uint
        {
            return (65);
        }

        public function get name():String
        {
            return ("ScriptLimits");
        }

        public function get version():uint
        {
            return (7);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "MaxRecursionDepth: ") + maxRecursionDepth) + ", ") + "ScriptTimeoutSeconds: ") + _SafeStr_376);
        }


    }
}


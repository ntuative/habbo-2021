package com.codeazur.as3swf.tags
{
    public class TagDefineShape3 extends TagDefineShape2 implements IDefinitionTag 
    {

        public static const TYPE:uint = 32;


        override public function get type():uint
        {
            return (32);
        }

        override public function get name():String
        {
            return ("DefineShape3");
        }

        override public function get version():uint
        {
            return (3);
        }

        override public function get level():uint
        {
            return (3);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Bounds: ") + shapeBounds);
            return (_local_2 + shapes.toString((_arg_1 + 2)));
        }


    }
}


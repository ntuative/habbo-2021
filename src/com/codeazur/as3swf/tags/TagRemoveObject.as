package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagRemoveObject implements _SafeStr_54 
    {

        public static const TYPE:uint = 5;

        public var characterId:uint = 0;
        public var depth:uint;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            characterId = _arg_1.readUI16();
            depth = _arg_1.readUI16();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 4);
            _arg_1.writeUI16(characterId);
            _arg_1.writeUI16(depth);
        }

        public function get type():uint
        {
            return (5);
        }

        public function get name():String
        {
            return ("RemoveObject");
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
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "CharacterID: ") + characterId) + ", ") + "Depth: ") + depth);
        }


    }
}


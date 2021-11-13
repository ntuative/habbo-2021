package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFColorTransform;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineButtonCxform implements IDefinitionTag 
    {

        public static const TYPE:uint = 23;

        public var _SafeStr_347:SWFColorTransform;
        protected var _SafeStr_720:uint;


        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_347 = _arg_1.readCXFORM();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeCXFORM(_SafeStr_347);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineButtonCxform = new TagDefineButtonCxform();
            _local_1.characterId = characterId;
            _local_1._SafeStr_347 = _SafeStr_347.clone();
            return (_local_1);
        }

        public function get type():uint
        {
            return (23);
        }

        public function get name():String
        {
            return ("DefineButtonCxform");
        }

        public function get version():uint
        {
            return (2);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "ColorTransform: ") + _SafeStr_347);
        }


    }
}


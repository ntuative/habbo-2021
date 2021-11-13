package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineScalingGrid implements IDefinitionTag 
    {

        public static const TYPE:uint = 78;

        public var _SafeStr_336:SWFRectangle;
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
            _SafeStr_336 = _arg_1.readRECT();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeRECT(_SafeStr_336);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineScalingGrid = new TagDefineScalingGrid();
            _local_1.characterId = characterId;
            _local_1._SafeStr_336 = _SafeStr_336.clone();
            return (_local_1);
        }

        public function get type():uint
        {
            return (78);
        }

        public function get name():String
        {
            return ("DefineScalingGrid");
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
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "CharacterID: ") + characterId) + ", ") + "Splitter: ") + _SafeStr_336);
        }


    }
}


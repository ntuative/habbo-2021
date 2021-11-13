package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFSoundInfo;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineButtonSound implements IDefinitionTag 
    {

        public static const TYPE:uint = 17;

        public var buttonSoundChar0:uint;
        public var buttonSoundChar1:uint;
        public var buttonSoundChar2:uint;
        public var buttonSoundChar3:uint;
        public var buttonSoundInfo0:SWFSoundInfo;
        public var buttonSoundInfo1:SWFSoundInfo;
        public var buttonSoundInfo2:SWFSoundInfo;
        public var buttonSoundInfo3:SWFSoundInfo;
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
            buttonSoundChar0 = _arg_1.readUI16();
            if (buttonSoundChar0 != 0)
            {
                buttonSoundInfo0 = _arg_1.readSOUNDINFO();
            };
            buttonSoundChar1 = _arg_1.readUI16();
            if (buttonSoundChar1 != 0)
            {
                buttonSoundInfo1 = _arg_1.readSOUNDINFO();
            };
            buttonSoundChar2 = _arg_1.readUI16();
            if (buttonSoundChar2 != 0)
            {
                buttonSoundInfo2 = _arg_1.readSOUNDINFO();
            };
            buttonSoundChar3 = _arg_1.readUI16();
            if (buttonSoundChar3 != 0)
            {
                buttonSoundInfo3 = _arg_1.readSOUNDINFO();
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeUI16(buttonSoundChar0);
            if (buttonSoundChar0 != 0)
            {
                _local_3.writeSOUNDINFO(buttonSoundInfo0);
            };
            _local_3.writeUI16(buttonSoundChar1);
            if (buttonSoundChar1 != 0)
            {
                _local_3.writeSOUNDINFO(buttonSoundInfo1);
            };
            _local_3.writeUI16(buttonSoundChar2);
            if (buttonSoundChar2 != 0)
            {
                _local_3.writeSOUNDINFO(buttonSoundInfo2);
            };
            _local_3.writeUI16(buttonSoundChar3);
            if (buttonSoundChar3 != 0)
            {
                _local_3.writeSOUNDINFO(buttonSoundInfo3);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineButtonSound = new TagDefineButtonSound();
            _local_1.characterId = characterId;
            _local_1.buttonSoundChar0 = buttonSoundChar0;
            _local_1.buttonSoundChar1 = buttonSoundChar1;
            _local_1.buttonSoundChar2 = buttonSoundChar2;
            _local_1.buttonSoundChar3 = buttonSoundChar3;
            _local_1.buttonSoundInfo0 = buttonSoundInfo0.clone();
            _local_1.buttonSoundInfo1 = buttonSoundInfo1.clone();
            _local_1.buttonSoundInfo2 = buttonSoundInfo2.clone();
            _local_1.buttonSoundInfo3 = buttonSoundInfo3.clone();
            return (_local_1);
        }

        public function get type():uint
        {
            return (17);
        }

        public function get name():String
        {
            return ("DefineButtonSound");
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
            return (((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ButtonID: ") + characterId) + ", ") + "ButtonSoundChars: ") + buttonSoundChar0) + ",") + buttonSoundChar1) + ",") + buttonSoundChar2) + ",") + buttonSoundChar3);
        }


    }
}


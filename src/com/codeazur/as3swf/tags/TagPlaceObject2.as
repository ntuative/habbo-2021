package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagPlaceObject2 extends TagPlaceObject implements _SafeStr_54 
    {

        public static const TYPE:uint = 26;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.readUI8();
            hasClipActions = (!((_local_5 & 0x80) == 0));
            hasClipDepth = (!((_local_5 & 0x40) == 0));
            hasName = (!((_local_5 & 0x20) == 0));
            hasRatio = (!((_local_5 & 0x10) == 0));
            hasColorTransform = (!((_local_5 & 0x08) == 0));
            hasMatrix = (!((_local_5 & 0x04) == 0));
            hasCharacter = (!((_local_5 & 0x02) == 0));
            hasMove = (!((_local_5 & 0x01) == 0));
            depth = _arg_1.readUI16();
            if (hasCharacter)
            {
                characterId = _arg_1.readUI16();
            };
            if (hasMatrix)
            {
                matrix = _arg_1.readMATRIX();
            };
            if (hasColorTransform)
            {
                colorTransform = _arg_1.readCXFORMWITHALPHA();
            };
            if (hasRatio)
            {
                _SafeStr_286 = _arg_1.readUI16();
            };
            if (hasName)
            {
                instanceName = _arg_1.readString();
            };
            if (hasClipDepth)
            {
                clipDepth = _arg_1.readUI16();
            };
            if (hasClipActions)
            {
                _SafeStr_287 = _arg_1.readCLIPACTIONS(_arg_3);
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_4:SWFData = new SWFData();
            if (hasMove)
            {
                _local_3 = (_local_3 | 0x01);
            };
            if (hasCharacter)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (hasMatrix)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (hasColorTransform)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (hasRatio)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (hasName)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (hasClipDepth)
            {
                _local_3 = (_local_3 | 0x40);
            };
            if (hasClipActions)
            {
                _local_3 = (_local_3 | 0x80);
            };
            _local_4.writeUI8(_local_3);
            _local_4.writeUI16(depth);
            if (hasCharacter)
            {
                _local_4.writeUI16(characterId);
            };
            if (hasMatrix)
            {
                _local_4.writeMATRIX(matrix);
            };
            if (hasColorTransform)
            {
                _local_4.writeCXFORM(colorTransform);
            };
            if (hasRatio)
            {
                _local_4.writeUI16(_SafeStr_286);
            };
            if (hasName)
            {
                _local_4.writeString(instanceName);
            };
            if (hasClipDepth)
            {
                _local_4.writeUI16(clipDepth);
            };
            if (hasClipActions)
            {
                _local_4.writeCLIPACTIONS(_SafeStr_287, _arg_2);
            };
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        override public function get type():uint
        {
            return (26);
        }

        override public function get name():String
        {
            return ("PlaceObject2");
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
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Depth: ") + depth);
            if (hasCharacter)
            {
                _local_2 = (_local_2 + (", CharacterID: " + characterId));
            };
            if (hasMatrix)
            {
                _local_2 = (_local_2 + (", Matrix: " + matrix.toString()));
            };
            if (hasColorTransform)
            {
                _local_2 = (_local_2 + (", ColorTransform: " + colorTransform));
            };
            if (hasRatio)
            {
                _local_2 = (_local_2 + (", Ratio: " + _SafeStr_286));
            };
            if (hasName)
            {
                _local_2 = (_local_2 + (", Name: " + instanceName));
            };
            if (hasClipDepth)
            {
                _local_2 = (_local_2 + (", ClipDepth: " + clipDepth));
            };
            if (((hasClipActions) && (!(_SafeStr_287 == null))))
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + _SafeStr_287.toString((_arg_1 + 2))));
            };
            return (_local_2);
        }


    }
}


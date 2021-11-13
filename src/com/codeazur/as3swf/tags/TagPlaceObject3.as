package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_81;
    import com.codeazur.as3swf.utils.ColorUtils;
    import com.codeazur.utils.StringUtils;

    public class TagPlaceObject3 extends TagPlaceObject2 implements _SafeStr_54 
    {

        public static const TYPE:uint = 70;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint;
            var _local_8:uint;
            var _local_7:uint = _arg_1.readUI8();
            hasClipActions = (!((_local_7 & 0x80) == 0));
            hasClipDepth = (!((_local_7 & 0x40) == 0));
            hasName = (!((_local_7 & 0x20) == 0));
            hasRatio = (!((_local_7 & 0x10) == 0));
            hasColorTransform = (!((_local_7 & 0x08) == 0));
            hasMatrix = (!((_local_7 & 0x04) == 0));
            hasCharacter = (!((_local_7 & 0x02) == 0));
            hasMove = (!((_local_7 & 0x01) == 0));
            var _local_6:uint = _arg_1.readUI8();
            hasBitmapBackgroundColor = (!((_local_6 & 0x40) == 0));
            hasVisibility = (!((_local_6 & 0x20) == 0));
            hasImage = (!((_local_6 & 0x10) == 0));
            hasClassName = (!((_local_6 & 0x08) == 0));
            hasCacheAsBitmap = (!((_local_6 & 0x04) == 0));
            hasBlendMode = (!((_local_6 & 0x02) == 0));
            hasFilterList = (!((_local_6 & 0x01) == 0));
            depth = _arg_1.readUI16();
            if (hasClassName)
            {
                className = _arg_1.readString();
            };
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
            if (hasFilterList)
            {
                _local_5 = _arg_1.readUI8();
                _local_8 = 0;
                while (_local_8 < _local_5)
                {
                    _SafeStr_739.push(_arg_1.readFILTER());
                    _local_8++;
                };
            };
            if (hasBlendMode)
            {
                blendMode = _arg_1.readUI8();
            };
            if (hasCacheAsBitmap)
            {
                bitmapCache = _arg_1.readUI8();
            };
            if (hasClipActions)
            {
                _SafeStr_287 = _arg_1.readCLIPACTIONS(_arg_3);
            };
            if (hasBitmapBackgroundColor)
            {
                bitmapBackgroundColor = _arg_1.readARGB();
            };
            if (hasVisibility)
            {
                visibility = _arg_1.readUI8();
            };
        }

        protected function prepareBody():SWFData
        {
            var _local_1:uint;
            var _local_4:uint;
            var _local_5:SWFData = new SWFData();
            var _local_3:uint;
            if (hasClipActions)
            {
                _local_3 = (_local_3 | 0x80);
            };
            if (hasClipDepth)
            {
                _local_3 = (_local_3 | 0x40);
            };
            if (hasName)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (hasRatio)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (hasColorTransform)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (hasMatrix)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (hasCharacter)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (hasMove)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_5.writeUI8(_local_3);
            var _local_2:uint;
            if (hasImage)
            {
                _local_2 = (_local_2 | 0x10);
            };
            if (hasClassName)
            {
                _local_2 = (_local_2 | 0x08);
            };
            if (hasCacheAsBitmap)
            {
                _local_2 = (_local_2 | 0x04);
            };
            if (hasBlendMode)
            {
                _local_2 = (_local_2 | 0x02);
            };
            if (hasFilterList)
            {
                _local_2 = (_local_2 | 0x01);
            };
            _local_5.writeUI8(_local_2);
            _local_5.writeUI16(depth);
            if (hasClassName)
            {
                _local_5.writeString(className);
            };
            if (hasCharacter)
            {
                _local_5.writeUI16(characterId);
            };
            if (hasMatrix)
            {
                _local_5.writeMATRIX(matrix);
            };
            if (hasColorTransform)
            {
                _local_5.writeCXFORM(colorTransform);
            };
            if (hasRatio)
            {
                _local_5.writeUI16(_SafeStr_286);
            };
            if (hasName)
            {
                _local_5.writeString(instanceName);
            };
            if (hasClipDepth)
            {
                _local_5.writeUI16(clipDepth);
            };
            if (hasFilterList)
            {
                _local_1 = _SafeStr_739.length;
                _local_5.writeUI8(_local_1);
                _local_4 = 0;
                while (_local_4 < _local_1)
                {
                    _local_5.writeFILTER(_SafeStr_739[_local_4]);
                    _local_4++;
                };
            };
            if (hasBlendMode)
            {
                _local_5.writeUI8(blendMode);
            };
            if (hasCacheAsBitmap)
            {
                _local_5.writeUI8(bitmapCache);
            };
            if (hasClipActions)
            {
                _local_5.writeCLIPACTIONS(_SafeStr_287, version);
            };
            if (hasBitmapBackgroundColor)
            {
                _local_5.writeARGB(bitmapBackgroundColor);
            };
            if (hasVisibility)
            {
                _local_5.writeUI8(visibility);
            };
            return (_local_5);
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = prepareBody();
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        override public function get type():uint
        {
            return (70);
        }

        override public function get name():String
        {
            return ("PlaceObject3");
        }

        override public function get version():uint
        {
            return (8);
        }

        override public function get level():uint
        {
            return (3);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Depth: ") + depth);
            if (hasClassName)
            {
                _local_2 = (_local_2 + (", ClassName: " + className));
            };
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
            if (hasBlendMode)
            {
                _local_2 = (_local_2 + (", BlendMode: " + _SafeStr_81.toString(blendMode)));
            };
            if (hasCacheAsBitmap)
            {
                _local_2 = (_local_2 + (", CacheAsBitmap: " + bitmapCache));
            };
            if (hasVisibility)
            {
                _local_2 = (_local_2 + (", Visibility: " + visibility));
            };
            if (hasBitmapBackgroundColor)
            {
                _local_2 = (_local_2 + (", BitmapBackgroundColor: " + ColorUtils.argbToString(bitmapBackgroundColor)));
            };
            if (hasFilterList)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Filters:"));
                _local_3 = 0;
                while (_local_3 < surfaceFilterList.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + surfaceFilterList[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            if (hasClipActions)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + _SafeStr_287.toString((_arg_1 + 2))));
            };
            return (_local_2);
        }


    }
}


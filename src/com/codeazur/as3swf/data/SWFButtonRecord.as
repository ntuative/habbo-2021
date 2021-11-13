package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.filters.IFilter;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_81;
    import com.codeazur.utils.StringUtils;

    public class SWFButtonRecord 
    {

        public var hasBlendMode:Boolean = false;
        public var hasFilterList:Boolean = false;
        public var _SafeStr_329:Boolean;
        public var _SafeStr_330:Boolean;
        public var _SafeStr_331:Boolean;
        public var _SafeStr_332:Boolean;
        public var characterId:uint;
        public var placeDepth:uint;
        public var _SafeStr_333:SWFMatrix;
        public var colorTransform:SWFColorTransformWithAlpha;
        public var blendMode:uint;
        protected var _SafeStr_702:Vector.<IFilter>;

        public function SWFButtonRecord(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            _SafeStr_702 = new Vector.<IFilter>();
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get filterList():Vector.<IFilter>
        {
            return (_SafeStr_702);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            var _local_3:uint;
            var _local_5:uint;
            var _local_4:uint = _arg_1.readUI8();
            _SafeStr_329 = (!((_local_4 & 0x08) == 0));
            _SafeStr_330 = (!((_local_4 & 0x04) == 0));
            _SafeStr_331 = (!((_local_4 & 0x02) == 0));
            _SafeStr_332 = (!((_local_4 & 0x01) == 0));
            characterId = _arg_1.readUI16();
            placeDepth = _arg_1.readUI16();
            _SafeStr_333 = _arg_1.readMATRIX();
            if (_arg_2 >= 2)
            {
                colorTransform = _arg_1.readCXFORMWITHALPHA();
                hasFilterList = (!((_local_4 & 0x10) == 0));
                if (hasFilterList)
                {
                    _local_3 = _arg_1.readUI8();
                    _local_5 = 0;
                    while (_local_5 < _local_3)
                    {
                        _SafeStr_702.push(_arg_1.readFILTER());
                        _local_5++;
                    };
                };
                hasBlendMode = (!((_local_4 & 0x20) == 0));
                if (hasBlendMode)
                {
                    blendMode = _arg_1.readUI8();
                };
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            var _local_3:uint;
            var _local_5:uint;
            var _local_4:uint;
            if (((_arg_2 >= 2) && (hasBlendMode)))
            {
                _local_4 = (_local_4 | 0x20);
            };
            if (((_arg_2 >= 2) && (hasFilterList)))
            {
                _local_4 = (_local_4 | 0x10);
            };
            if (_SafeStr_329)
            {
                _local_4 = (_local_4 | 0x08);
            };
            if (_SafeStr_330)
            {
                _local_4 = (_local_4 | 0x04);
            };
            if (_SafeStr_331)
            {
                _local_4 = (_local_4 | 0x02);
            };
            if (_SafeStr_332)
            {
                _local_4 = (_local_4 | 0x01);
            };
            _arg_1.writeUI8(_local_4);
            _arg_1.writeUI16(characterId);
            _arg_1.writeUI16(placeDepth);
            _arg_1.writeMATRIX(_SafeStr_333);
            if (_arg_2 >= 2)
            {
                _arg_1.writeCXFORMWITHALPHA(colorTransform);
                if (hasFilterList)
                {
                    _local_3 = filterList.length;
                    _arg_1.writeUI8(_local_3);
                    _local_5 = 0;
                    while (_local_5 < _local_3)
                    {
                        _arg_1.writeFILTER(filterList[_local_5]);
                        _local_5++;
                    };
                };
                if (hasBlendMode)
                {
                    _arg_1.writeUI8(blendMode);
                };
            };
        }

        public function clone():SWFButtonRecord
        {
            var _local_2:uint;
            var _local_1:SWFButtonRecord = new SWFButtonRecord();
            _local_1.hasBlendMode = hasBlendMode;
            _local_1.hasFilterList = hasFilterList;
            _local_1._SafeStr_329 = _SafeStr_329;
            _local_1._SafeStr_330 = _SafeStr_330;
            _local_1._SafeStr_331 = _SafeStr_331;
            _local_1._SafeStr_332 = _SafeStr_332;
            _local_1.characterId = characterId;
            _local_1.placeDepth = placeDepth;
            _local_1._SafeStr_333 = _SafeStr_333.clone();
            if (colorTransform)
            {
                _local_1.colorTransform = (colorTransform.clone() as SWFColorTransformWithAlpha);
            };
            _local_2 = 0;
            while (_local_2 < filterList.length)
            {
                _local_1.filterList.push(filterList[_local_2].clone());
                _local_2++;
            };
            _local_1.blendMode = blendMode;
            return (_local_1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = (((("Depth: " + placeDepth) + ", CharacterID: ") + characterId) + ", States: ");
            var _local_4:Array = [];
            if (_SafeStr_332)
            {
                _local_4.push("up");
            };
            if (_SafeStr_331)
            {
                _local_4.push("over");
            };
            if (_SafeStr_330)
            {
                _local_4.push("down");
            };
            if (_SafeStr_329)
            {
                _local_4.push("hit");
            };
            _local_2 = (_local_2 + _local_4.join(","));
            if (hasBlendMode)
            {
                _local_2 = (_local_2 + (", BlendMode: " + _SafeStr_81.toString(blendMode)));
            };
            if (((_SafeStr_333) && (!(_SafeStr_333.isIdentity()))))
            {
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "Matrix: ") + _SafeStr_333));
            };
            if (((colorTransform) && (!(colorTransform.isIdentity()))))
            {
                _local_2 = (_local_2 + ((("\n" + StringUtils.repeat((_arg_1 + 2))) + "ColorTransform: ") + colorTransform));
            };
            if (hasFilterList)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Filters:"));
                _local_3 = 0;
                while (_local_3 < filterList.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + filterList[_local_3].toString((_arg_1 + 4))));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}


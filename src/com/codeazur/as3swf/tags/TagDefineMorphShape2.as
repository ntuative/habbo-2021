package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.SWFMorphLineStyle2;
    import com.codeazur.utils.StringUtils;

    public class TagDefineMorphShape2 extends TagDefineMorphShape implements ITag 
    {

        public static const TYPE:uint = 84;

        public var _SafeStr_319:SWFRectangle;
        public var endEdgeBounds:SWFRectangle;
        public var usesNonScalingStrokes:Boolean;
        public var usesScalingStrokes:Boolean;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_7:uint;
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_299 = _arg_1.readRECT();
            endBounds = _arg_1.readRECT();
            _SafeStr_319 = _arg_1.readRECT();
            endEdgeBounds = _arg_1.readRECT();
            var _local_6:uint = _arg_1.readUI8();
            usesNonScalingStrokes = (!((_local_6 & 0x02) == 0));
            usesScalingStrokes = (!((_local_6 & 0x01) == 0));
            var _local_5:uint = _arg_1.readUI32();
            var _local_8:uint = _arg_1.readUI8();
            if (_local_8 == 0xFF)
            {
                _local_8 = _arg_1.readUI16();
            };
            _local_7 = 0;
            while (_local_7 < _local_8)
            {
                _SafeStr_732.push(_arg_1.readMORPHFILLSTYLE());
                _local_7++;
            };
            var _local_9:uint = _arg_1.readUI8();
            if (_local_9 == 0xFF)
            {
                _local_9 = _arg_1.readUI16();
            };
            _local_7 = 0;
            while (_local_7 < _local_9)
            {
                _SafeStr_733.push(_arg_1.readMORPHLINESTYLE2());
                _local_7++;
            };
            _SafeStr_300 = _arg_1.readSHAPE();
            endEdges = _arg_1.readSHAPE();
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:uint;
            var _local_6:SWFData = new SWFData();
            _local_6.writeUI16(characterId);
            _local_6.writeRECT(_SafeStr_299);
            _local_6.writeRECT(endBounds);
            _local_6.writeRECT(_SafeStr_319);
            _local_6.writeRECT(endEdgeBounds);
            var _local_3:uint;
            if (usesNonScalingStrokes)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (usesScalingStrokes)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_6.writeUI8(_local_3);
            var _local_7:SWFData = new SWFData();
            var _local_5:uint = _SafeStr_732.length;
            if (_local_5 > 254)
            {
                _local_7.writeUI8(0xFF);
                _local_7.writeUI16(_local_5);
            }
            else
            {
                _local_7.writeUI8(_local_5);
            };
            _local_4 = 0;
            while (_local_4 < _local_5)
            {
                _local_7.writeMORPHFILLSTYLE(_SafeStr_732[_local_4]);
                _local_4++;
            };
            var _local_8:uint = _SafeStr_733.length;
            if (_local_8 > 254)
            {
                _local_7.writeUI8(0xFF);
                _local_7.writeUI16(_local_8);
            }
            else
            {
                _local_7.writeUI8(_local_8);
            };
            _local_4 = 0;
            while (_local_4 < _local_8)
            {
                _local_7.writeMORPHLINESTYLE2(SWFMorphLineStyle2(_SafeStr_733[_local_4]));
                _local_4++;
            };
            _local_7.writeSHAPE(_SafeStr_300);
            _local_6.writeUI32(_local_7.length);
            _local_6.writeBytes(_local_7);
            _local_6.writeSHAPE(endEdges);
            _arg_1.writeTagHeader(type, _local_6.length);
            _arg_1.writeBytes(_local_6);
        }

        override public function get type():uint
        {
            return (84);
        }

        override public function get name():String
        {
            return ("DefineMorphShape2");
        }

        override public function get version():uint
        {
            return (8);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_3:String = StringUtils.repeat((_arg_1 + 2));
            var _local_5:String = StringUtils.repeat((_arg_1 + 4));
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId);
            _local_2 = (_local_2 + (("\n" + _local_3) + "Bounds:"));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "StartBounds: ") + _SafeStr_299.toString()));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "EndBounds: ") + endBounds.toString()));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "StartEdgeBounds: ") + _SafeStr_319.toString()));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "EndEdgeBounds: ") + endEdgeBounds.toString()));
            if (_SafeStr_732.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + _local_3) + "FillStyles:"));
                _local_4 = 0;
                while (_local_4 < _SafeStr_732.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + _local_5) + "[") + (_local_4 + 1)) + "] ") + _SafeStr_732[_local_4].toString()));
                    _local_4++;
                };
            };
            if (_SafeStr_733.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + _local_3) + "LineStyles:"));
                _local_4 = 0;
                while (_local_4 < _SafeStr_733.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + _local_5) + "[") + (_local_4 + 1)) + "] ") + _SafeStr_733[_local_4].toString()));
                    _local_4++;
                };
            };
            _local_2 = (_local_2 + _SafeStr_300.toString((_arg_1 + 2)));
            return (_local_2 + endEdges.toString((_arg_1 + 2)));
        }


    }
}


package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.data.SWFShape;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFMorphFillStyle;
    import com.codeazur.as3swf.data.SWFMorphLineStyle;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.SWFShapeRecord;
    import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;
    import com.codeazur.as3swf.data.SWFShapeRecordStraightEdge;
    import com.codeazur.as3swf.data.SWFShapeRecordCurvedEdge;
    import com.codeazur.as3swf.exporters.core.IShapeExporter;
    import com.codeazur.utils.StringUtils;

    public class TagDefineMorphShape implements IDefinitionTag 
    {

        public static const TYPE:uint = 46;

        public var _SafeStr_299:SWFRectangle;
        public var endBounds:SWFRectangle;
        public var _SafeStr_300:SWFShape;
        public var endEdges:SWFShape;
        protected var _SafeStr_720:uint;
        protected var _SafeStr_732:Vector.<SWFMorphFillStyle>;
        protected var _SafeStr_733:Vector.<SWFMorphLineStyle>;

        public function TagDefineMorphShape()
        {
            _SafeStr_732 = new Vector.<SWFMorphFillStyle>();
            _SafeStr_733 = new Vector.<SWFMorphLineStyle>();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get morphFillStyles():Vector.<SWFMorphFillStyle>
        {
            return (_SafeStr_732);
        }

        public function get morphLineStyles():Vector.<SWFMorphLineStyle>
        {
            return (_SafeStr_733);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_6:uint;
            _SafeStr_720 = _arg_1.readUI16();
            _SafeStr_299 = _arg_1.readRECT();
            endBounds = _arg_1.readRECT();
            var _local_5:uint = _arg_1.readUI32();
            var _local_7:uint = _arg_1.readUI8();
            if (_local_7 == 0xFF)
            {
                _local_7 = _arg_1.readUI16();
            };
            _local_6 = 0;
            while (_local_6 < _local_7)
            {
                _SafeStr_732.push(_arg_1.readMORPHFILLSTYLE());
                _local_6++;
            };
            var _local_8:uint = _arg_1.readUI8();
            if (_local_8 == 0xFF)
            {
                _local_8 = _arg_1.readUI16();
            };
            _local_6 = 0;
            while (_local_6 < _local_8)
            {
                _SafeStr_733.push(_arg_1.readMORPHLINESTYLE());
                _local_6++;
            };
            _SafeStr_300 = _arg_1.readSHAPE();
            endEdges = _arg_1.readSHAPE();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_5:SWFData = new SWFData();
            _local_5.writeUI16(characterId);
            _local_5.writeRECT(_SafeStr_299);
            _local_5.writeRECT(endBounds);
            var _local_6:SWFData = new SWFData();
            var _local_4:uint = _SafeStr_732.length;
            if (_local_4 > 254)
            {
                _local_6.writeUI8(0xFF);
                _local_6.writeUI16(_local_4);
            }
            else
            {
                _local_6.writeUI8(_local_4);
            };
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_6.writeMORPHFILLSTYLE(_SafeStr_732[_local_3]);
                _local_3++;
            };
            var _local_7:uint = _SafeStr_733.length;
            if (_local_7 > 254)
            {
                _local_6.writeUI8(0xFF);
                _local_6.writeUI16(_local_7);
            }
            else
            {
                _local_6.writeUI8(_local_7);
            };
            _local_3 = 0;
            while (_local_3 < _local_7)
            {
                _local_6.writeMORPHLINESTYLE(_SafeStr_733[_local_3]);
                _local_3++;
            };
            _local_6.writeSHAPE(_SafeStr_300);
            _local_5.writeUI32(_local_6.length);
            _local_5.writeBytes(_local_6);
            _local_5.writeSHAPE(endEdges);
            _arg_1.writeTagHeader(type, _local_5.length);
            _arg_1.writeBytes(_local_5);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineMorphShape = new TagDefineMorphShape();
            throw (new Error("Not implemented yet."));
        }

        public function export(_arg_1:IShapeExporter=null, _arg_2:Number=0):void
        {
            var _local_7:uint;
            var _local_5:SWFShapeRecord;
            var _local_12:SWFShapeRecord;
            var _local_15:SWFShapeRecord;
            var _local_11:SWFShapeRecordStyleChange;
            var _local_3:SWFShapeRecordStyleChange;
            var _local_14:SWFShapeRecordStraightEdge;
            var _local_10:SWFShapeRecordStraightEdge;
            var _local_6:SWFShapeRecordCurvedEdge;
            var _local_9:SWFShapeRecordCurvedEdge;
            var _local_8:uint;
            var _local_13:SWFShape = new SWFShape();
            var _local_4:uint = _SafeStr_300.records.length;
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_5 = _SafeStr_300.records[_local_7];
                if (((_local_5.type == 2) && (!(SWFShapeRecordStyleChange(_local_5).stateMoveTo))))
                {
                    _local_13.records.push(_local_5.clone());
                }
                else
                {
                    _local_12 = endEdges.records[_local_8++];
                    if (((_local_5.type == 4) && (_local_12.type == 3)))
                    {
                        _local_12 = convertToCurvedEdge((_local_12 as SWFShapeRecordStraightEdge));
                    }
                    else
                    {
                        if (((_local_5.type == 3) && (_local_12.type == 4)))
                        {
                            _local_5 = convertToCurvedEdge((_local_5 as SWFShapeRecordStraightEdge));
                        };
                    };
                    switch (_local_5.type)
                    {
                        case 2:
                            _local_11 = (_local_5.clone() as SWFShapeRecordStyleChange);
                            _local_3 = (_local_12 as SWFShapeRecordStyleChange);
                            _local_11.moveDeltaX = (_local_11.moveDeltaX + ((_local_3.moveDeltaX - _local_11.moveDeltaX) * _arg_2));
                            _local_11.moveDeltaY = (_local_11.moveDeltaY + ((_local_3.moveDeltaY - _local_11.moveDeltaY) * _arg_2));
                            _local_15 = _local_11;
                            break;
                        case 3:
                            _local_14 = (_local_5.clone() as SWFShapeRecordStraightEdge);
                            _local_10 = (_local_12 as SWFShapeRecordStraightEdge);
                            _local_14._SafeStr_301 = (_local_14._SafeStr_301 + ((_local_10._SafeStr_301 - _local_14._SafeStr_301) * _arg_2));
                            _local_14._SafeStr_302 = (_local_14._SafeStr_302 + ((_local_10._SafeStr_302 - _local_14._SafeStr_302) * _arg_2));
                            if (((!(_local_14._SafeStr_301 == 0)) && (!(_local_14._SafeStr_302 == 0))))
                            {
                                _local_14._SafeStr_303 = true;
                                _local_14._SafeStr_304 = false;
                            }
                            else
                            {
                                _local_14._SafeStr_303 = false;
                                _local_14._SafeStr_304 = (_local_14._SafeStr_301 == 0);
                            };
                            _local_15 = _local_14;
                            break;
                        case 4:
                            _local_6 = (_local_5.clone() as SWFShapeRecordCurvedEdge);
                            _local_9 = (_local_12 as SWFShapeRecordCurvedEdge);
                            _local_6.controlDeltaX = (_local_6.controlDeltaX + ((_local_9.controlDeltaX - _local_6.controlDeltaX) * _arg_2));
                            _local_6.controlDeltaY = (_local_6.controlDeltaY + ((_local_9.controlDeltaY - _local_6.controlDeltaY) * _arg_2));
                            _local_6._SafeStr_305 = (_local_6._SafeStr_305 + ((_local_9._SafeStr_305 - _local_6._SafeStr_305) * _arg_2));
                            _local_6._SafeStr_306 = (_local_6._SafeStr_306 + ((_local_9._SafeStr_306 - _local_6._SafeStr_306) * _arg_2));
                            _local_15 = _local_6;
                            break;
                        case 1:
                            _local_15 = _local_5.clone();
                        default:
                    };
                    _local_13.records.push(_local_15);
                };
                _local_7++;
            };
            _local_7 = 0;
            while (_local_7 < morphFillStyles.length)
            {
                _local_13.fillStyles.push(morphFillStyles[_local_7].getMorphedFillStyle(_arg_2));
                _local_7++;
            };
            _local_7 = 0;
            while (_local_7 < morphLineStyles.length)
            {
                _local_13.lineStyles.push(morphLineStyles[_local_7].getMorphedLineStyle(_arg_2));
                _local_7++;
            };
            _local_13.export(_arg_1);
        }

        protected function convertToCurvedEdge(_arg_1:SWFShapeRecordStraightEdge):SWFShapeRecordCurvedEdge
        {
            var _local_2:SWFShapeRecordCurvedEdge = new SWFShapeRecordCurvedEdge();
            _local_2.controlDeltaX = (_arg_1._SafeStr_301 / 2);
            _local_2.controlDeltaY = (_arg_1._SafeStr_302 / 2);
            _local_2._SafeStr_305 = _arg_1._SafeStr_301;
            _local_2._SafeStr_306 = _arg_1._SafeStr_302;
            return (_local_2);
        }

        public function get type():uint
        {
            return (46);
        }

        public function get name():String
        {
            return ("DefineMorphShape");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_3:String = StringUtils.repeat((_arg_1 + 2));
            var _local_5:String = StringUtils.repeat((_arg_1 + 4));
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId);
            _local_2 = (_local_2 + (("\n" + _local_3) + "Bounds:"));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "StartBounds: ") + _SafeStr_299.toString()));
            _local_2 = (_local_2 + ((("\n" + _local_5) + "EndBounds: ") + endBounds.toString()));
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


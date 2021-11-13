package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.utils.NumberUtils;
    import com.codeazur.as3swf.exporters.core.DefaultShapeExporter;
    import com.codeazur.as3swf.exporters.core.IShapeExporter;
    import com.codeazur.as3swf.data.etc.IEdge;
    import com.codeazur.as3swf.data.etc.StraightEdge;
    import com.codeazur.as3swf.data.etc.CurvedEdge;
    import flash.geom.Matrix;
    import com.codeazur.as3swf.utils.ColorUtils;
    import com.codeazur.as3swf.data.consts._SafeStr_94;
    import com.codeazur.as3swf.data.consts._SafeStr_87;
    import com.codeazur.as3swf.data.consts._SafeStr_86;
    import com.codeazur.as3swf.data.consts._SafeStr_89;
    import com.codeazur.utils.StringUtils;

    public class SWFShape 
    {

        protected var _SafeStr_703:Vector.<SWFShapeRecord>;
        protected var _SafeStr_704:Vector.<SWFFillStyle>;
        protected var _SafeStr_705:Vector.<SWFLineStyle>;
        protected var _referencePoint:Point;
        protected var fillEdgeMaps:Vector.<Dictionary>;
        protected var lineEdgeMaps:Vector.<Dictionary>;
        protected var currentFillEdgeMap:Dictionary;
        protected var currentLineEdgeMap:Dictionary;
        protected var _SafeStr_706:uint;
        protected var _SafeStr_707:Dictionary;
        protected var unitDivisor:Number;
        protected var _SafeStr_708:Boolean = false;

        public function SWFShape(_arg_1:SWFData=null, _arg_2:uint=1, _arg_3:Number=20)
        {
            _SafeStr_703 = new Vector.<SWFShapeRecord>();
            _SafeStr_704 = new Vector.<SWFFillStyle>();
            _SafeStr_705 = new Vector.<SWFLineStyle>();
            _referencePoint = new Point(0, 0);
            this.unitDivisor = _arg_3;
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get records():Vector.<SWFShapeRecord>
        {
            return (_SafeStr_703);
        }

        public function get fillStyles():Vector.<SWFFillStyle>
        {
            return (_SafeStr_704);
        }

        public function get lineStyles():Vector.<SWFLineStyle>
        {
            return (_SafeStr_705);
        }

        public function get referencePoint():Point
        {
            return (_referencePoint);
        }

        public function getMaxFillStyleIndex():uint
        {
            var _local_4:uint;
            var _local_3:SWFShapeRecord;
            var _local_2:SWFShapeRecordStyleChange;
            var _local_1:uint;
            _local_4 = 0;
            while (_local_4 < records.length)
            {
                _local_3 = records[_local_4];
                if (_local_3.type == 2)
                {
                    _local_2 = (_local_3 as SWFShapeRecordStyleChange);
                    if (_local_2.fillStyle0 > _local_1)
                    {
                        _local_1 = _local_2.fillStyle0;
                    };
                    if (_local_2.fillStyle1 > _local_1)
                    {
                        _local_1 = _local_2.fillStyle1;
                    };
                    if (_local_2._SafeStr_309) break;
                };
                _local_4++;
            };
            return (_local_1);
        }

        public function getMaxLineStyleIndex():uint
        {
            var _local_4:uint;
            var _local_3:SWFShapeRecord;
            var _local_2:SWFShapeRecordStyleChange;
            var _local_1:uint;
            _local_4 = 0;
            while (_local_4 < records.length)
            {
                _local_3 = records[_local_4];
                if (_local_3.type == 2)
                {
                    _local_2 = (_local_3 as SWFShapeRecordStyleChange);
                    if (_local_2.lineStyle > _local_1)
                    {
                        _local_1 = _local_2.lineStyle;
                    };
                    if (_local_2._SafeStr_309) break;
                };
                _local_4++;
            };
            return (_local_1);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint=1):void
        {
            _arg_1.resetBitsPending();
            var _local_4:uint = _arg_1.readUB(4);
            var _local_3:uint = _arg_1.readUB(4);
            readShapeRecords(_arg_1, _local_4, _local_3, _arg_2);
            determineReferencePoint();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint=1):void
        {
            var _local_4:uint = _arg_1.calculateMaxBits(false, [getMaxFillStyleIndex()]);
            var _local_3:uint = _arg_1.calculateMaxBits(false, [getMaxLineStyleIndex()]);
            _arg_1.resetBitsPending();
            _arg_1.writeUB(4, _local_4);
            _arg_1.writeUB(4, _local_3);
            writeShapeRecords(_arg_1, _local_4, _local_3, _arg_2);
        }

        protected function readShapeRecords(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:uint=1):void
        {
            var _local_6:SWFShapeRecord;
            var _local_5:Boolean;
            var _local_9:Boolean;
            var _local_7:uint;
            var _local_10:uint;
            var _local_8:SWFShapeRecordStyleChange;
            while (!(_local_6 is SWFShapeRecordEnd))
            {
                _local_5 = (_arg_1.readUB(1) == 1);
                if (_local_5)
                {
                    _local_9 = (_arg_1.readUB(1) == 1);
                    _local_7 = (_arg_1.readUB(4) + 2);
                    if (_local_9)
                    {
                        _local_6 = _arg_1.readSTRAIGHTEDGERECORD(_local_7);
                    }
                    else
                    {
                        _local_6 = _arg_1.readCURVEDEDGERECORD(_local_7);
                    };
                }
                else
                {
                    _local_10 = _arg_1.readUB(5);
                    if (_local_10 == 0)
                    {
                        _local_6 = new SWFShapeRecordEnd();
                    }
                    else
                    {
                        _local_8 = _arg_1.readSTYLECHANGERECORD(_local_10, _arg_2, _arg_3, _arg_4);
                        if (_local_8._SafeStr_309)
                        {
                            _arg_2 = _local_8._SafeStr_292;
                            _arg_3 = _local_8._SafeStr_293;
                        };
                        _local_6 = _local_8;
                    };
                };
                _SafeStr_703.push(_local_6);
            };
        }

        protected function writeShapeRecords(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:uint=1):void
        {
            var _local_6:uint;
            var _local_5:SWFShapeRecord;
            var _local_8:uint;
            var _local_7:SWFShapeRecordStyleChange;
            if (((records.length == 0) || (!(records[(records.length - 1)] is SWFShapeRecordEnd))))
            {
                records.push(new SWFShapeRecordEnd());
            };
            _local_6 = 0;
            while (_local_6 < records.length)
            {
                _local_5 = records[_local_6];
                if (_local_5.isEdgeRecord)
                {
                    _arg_1.writeUB(1, 1);
                    if (_local_5.type == 3)
                    {
                        _arg_1.writeUB(1, 1);
                        _arg_1.writeSTRAIGHTEDGERECORD(SWFShapeRecordStraightEdge(_local_5));
                    }
                    else
                    {
                        _arg_1.writeUB(1, 0);
                        _arg_1.writeCURVEDEDGERECORD(SWFShapeRecordCurvedEdge(_local_5));
                    };
                }
                else
                {
                    _arg_1.writeUB(1, 0);
                    if (_local_5.type == 1)
                    {
                        _arg_1.writeUB(5, 0);
                    }
                    else
                    {
                        _local_8 = 0;
                        _local_7 = (_local_5 as SWFShapeRecordStyleChange);
                        if (_local_7._SafeStr_309)
                        {
                            _local_8 = (_local_8 | 0x10);
                        };
                        if (_local_7._SafeStr_310)
                        {
                            _local_8 = (_local_8 | 0x08);
                        };
                        if (_local_7.stateFillStyle1)
                        {
                            _local_8 = (_local_8 | 0x04);
                        };
                        if (_local_7.stateFillStyle0)
                        {
                            _local_8 = (_local_8 | 0x02);
                        };
                        if (_local_7.stateMoveTo)
                        {
                            _local_8 = (_local_8 | 0x01);
                        };
                        _arg_1.writeUB(5, _local_8);
                        _arg_1.writeSTYLECHANGERECORD(_local_7, _arg_2, _arg_3, _arg_4);
                        if (_local_7._SafeStr_309)
                        {
                            _arg_2 = _local_7._SafeStr_292;
                            _arg_3 = _local_7._SafeStr_293;
                        };
                    };
                };
                _local_6++;
            };
        }

        protected function determineReferencePoint():void
        {
            var _local_1:SWFShapeRecordStyleChange = (_SafeStr_703[0] as SWFShapeRecordStyleChange);
            if (((_local_1) && (_local_1.stateMoveTo)))
            {
                referencePoint.x = NumberUtils.roundPixels400((_local_1.moveDeltaX / unitDivisor));
                referencePoint.y = NumberUtils.roundPixels400((_local_1.moveDeltaY / unitDivisor));
            };
        }

        public function export(_arg_1:IShapeExporter=null):void
        {
            var _local_2:int;
            _SafeStr_708 = false;
            createEdgeMaps();
            if (_arg_1 == null)
            {
                _arg_1 = new DefaultShapeExporter(null);
            };
            _arg_1.beginShape();
            _local_2 = 0;
            while (_local_2 < _SafeStr_706)
            {
                exportFillPath(_arg_1, _local_2);
                exportLinePath(_arg_1, _local_2);
                _local_2++;
            };
            _arg_1.endShape();
        }

        protected function createEdgeMaps():void
        {
            var _local_6:Number;
            var _local_1:Number;
            var _local_13:Point;
            var _local_15:Point;
            var _local_5:Point;
            var _local_11:int;
            var _local_12:int;
            var _local_16:uint;
            var _local_14:uint;
            var _local_10:uint;
            var _local_17:Vector.<IEdge> = undefined;
            var _local_3:uint;
            var _local_9:SWFShapeRecord;
            var _local_4:SWFShapeRecordStyleChange;
            var _local_18:SWFShapeRecordStraightEdge;
            var _local_2:SWFShapeRecordCurvedEdge;
            var _local_7:Number;
            var _local_8:Number;
            if (!_SafeStr_708)
            {
                _local_6 = 0;
                _local_1 = 0;
                _local_11 = 0;
                _local_12 = 0;
                _local_16 = 0;
                _local_14 = 0;
                _local_10 = 0;
                _local_17 = new Vector.<IEdge>();
                _SafeStr_706 = 0;
                fillEdgeMaps = new Vector.<Dictionary>();
                lineEdgeMaps = new Vector.<Dictionary>();
                currentFillEdgeMap = new Dictionary();
                currentLineEdgeMap = new Dictionary();
                _local_3 = 0;
                while (_local_3 < _SafeStr_703.length)
                {
                    _local_9 = _SafeStr_703[_local_3];
                    switch (_local_9.type)
                    {
                        case 2:
                            _local_4 = (_local_9 as SWFShapeRecordStyleChange);
                            if ((((_local_4._SafeStr_310) || (_local_4.stateFillStyle0)) || (_local_4.stateFillStyle1)))
                            {
                                processSubPath(_local_17, _local_10, _local_16, _local_14);
                                _local_17 = new Vector.<IEdge>();
                            };
                            if (_local_4._SafeStr_309)
                            {
                                _local_11 = _SafeStr_704.length;
                                _local_12 = _SafeStr_705.length;
                                appendFillStyles(_SafeStr_704, _local_4.fillStyles);
                                appendLineStyles(_SafeStr_705, _local_4.lineStyles);
                            };
                            if (((((((_local_4._SafeStr_310) && (_local_4.lineStyle == 0)) && (_local_4.stateFillStyle0)) && (_local_4.fillStyle0 == 0)) && (_local_4.stateFillStyle1)) && (_local_4.fillStyle1 == 0)))
                            {
                                cleanEdgeMap(currentFillEdgeMap);
                                cleanEdgeMap(currentLineEdgeMap);
                                fillEdgeMaps.push(currentFillEdgeMap);
                                lineEdgeMaps.push(currentLineEdgeMap);
                                currentFillEdgeMap = new Dictionary();
                                currentLineEdgeMap = new Dictionary();
                                _local_10 = 0;
                                _local_16 = 0;
                                _local_14 = 0;
                                _SafeStr_706++;
                            }
                            else
                            {
                                if (_local_4._SafeStr_310)
                                {
                                    _local_10 = _local_4.lineStyle;
                                    if (_local_10 > 0)
                                    {
                                        _local_10 = (_local_10 + _local_12);
                                    };
                                };
                                if (_local_4.stateFillStyle0)
                                {
                                    _local_16 = _local_4.fillStyle0;
                                    if (_local_16 > 0)
                                    {
                                        _local_16 = (_local_16 + _local_11);
                                    };
                                };
                                if (_local_4.stateFillStyle1)
                                {
                                    _local_14 = _local_4.fillStyle1;
                                    if (_local_14 > 0)
                                    {
                                        _local_14 = (_local_14 + _local_11);
                                    };
                                };
                            };
                            if (_local_4.stateMoveTo)
                            {
                                _local_6 = (_local_4.moveDeltaX / unitDivisor);
                                _local_1 = (_local_4.moveDeltaY / unitDivisor);
                            };
                            break;
                        case 3:
                            _local_18 = (_local_9 as SWFShapeRecordStraightEdge);
                            _local_13 = new Point(NumberUtils.roundPixels400(_local_6), NumberUtils.roundPixels400(_local_1));
                            if (_local_18._SafeStr_303)
                            {
                                _local_6 = (_local_6 + (_local_18._SafeStr_301 / unitDivisor));
                                _local_1 = (_local_1 + (_local_18._SafeStr_302 / unitDivisor));
                            }
                            else
                            {
                                if (_local_18._SafeStr_304)
                                {
                                    _local_1 = (_local_1 + (_local_18._SafeStr_302 / unitDivisor));
                                }
                                else
                                {
                                    _local_6 = (_local_6 + (_local_18._SafeStr_301 / unitDivisor));
                                };
                            };
                            _local_15 = new Point(NumberUtils.roundPixels400(_local_6), NumberUtils.roundPixels400(_local_1));
                            _local_17.push(new StraightEdge(_local_13, _local_15, _local_10, _local_14));
                            break;
                        case 4:
                            _local_2 = (_local_9 as SWFShapeRecordCurvedEdge);
                            _local_13 = new Point(NumberUtils.roundPixels400(_local_6), NumberUtils.roundPixels400(_local_1));
                            _local_7 = (_local_6 + (_local_2.controlDeltaX / unitDivisor));
                            _local_8 = (_local_1 + (_local_2.controlDeltaY / unitDivisor));
                            _local_6 = (_local_7 + (_local_2._SafeStr_305 / unitDivisor));
                            _local_1 = (_local_8 + (_local_2._SafeStr_306 / unitDivisor));
                            _local_5 = new Point(_local_7, _local_8);
                            _local_15 = new Point(NumberUtils.roundPixels400(_local_6), NumberUtils.roundPixels400(_local_1));
                            _local_17.push(new CurvedEdge(_local_13, _local_5, _local_15, _local_10, _local_14));
                            break;
                        case 1:
                            processSubPath(_local_17, _local_10, _local_16, _local_14);
                            cleanEdgeMap(currentFillEdgeMap);
                            cleanEdgeMap(currentLineEdgeMap);
                            fillEdgeMaps.push(currentFillEdgeMap);
                            lineEdgeMaps.push(currentLineEdgeMap);
                            _SafeStr_706++;
                        default:
                    };
                    _local_3++;
                };
                _SafeStr_708 = true;
            };
        }

        protected function processSubPath(_arg_1:Vector.<IEdge>, _arg_2:uint, _arg_3:uint, _arg_4:uint):void
        {
            var _local_5:Vector.<IEdge> = undefined;
            var _local_6:int;
            if (_arg_3 != 0)
            {
                _local_5 = (currentFillEdgeMap[_arg_3] as Vector.<IEdge>);
                if (_local_5 == null)
                {
                    var _local_7:Vector.<IEdge> = new Vector.<IEdge>();
                    currentFillEdgeMap[_arg_3] = _local_7;
                    _local_5 = _local_7;
                };
                _local_6 = (_arg_1.length - 1);
                while (_local_6 >= 0)
                {
                    _local_5.push(_arg_1[_local_6].reverseWithNewFillStyle(_arg_3));
                    _local_6--;
                };
            };
            if (_arg_4 != 0)
            {
                _local_5 = (currentFillEdgeMap[_arg_4] as Vector.<IEdge>);
                if (_local_5 == null)
                {
                    _local_7 = new Vector.<IEdge>();
                    currentFillEdgeMap[_arg_4] = _local_7;
                    _local_5 = _local_7;
                };
                appendEdges(_local_5, _arg_1);
            };
            if (_arg_2 != 0)
            {
                _local_5 = (currentLineEdgeMap[_arg_2] as Vector.<IEdge>);
                if (_local_5 == null)
                {
                    _local_7 = new Vector.<IEdge>();
                    currentLineEdgeMap[_arg_2] = _local_7;
                    _local_5 = _local_7;
                };
                appendEdges(_local_5, _arg_1);
            };
        }

        protected function exportFillPath(_arg_1:IShapeExporter, _arg_2:uint):void
        {
            var _local_5:uint;
            var _local_4:IEdge;
            var _local_6:Matrix;
            var _local_14:SWFFillStyle;
            var _local_8:Array;
            var _local_13:Array;
            var _local_15:Array;
            var _local_12:SWFGradientRecord;
            var _local_16:uint;
            var _local_7:SWFMatrix;
            var _local_3:CurvedEdge;
            var _local_10:Vector.<IEdge> = createPathFromEdgeMap(fillEdgeMaps[_arg_2]);
            var _local_11:Point = new Point(1.79769313486232E308, 1.79769313486232E308);
            var _local_9:int = 0xFFFFFFFF;
            if (_local_10.length > 0)
            {
                _arg_1.beginFills();
                _local_5 = 0;
                while (_local_5 < _local_10.length)
                {
                    _local_4 = _local_10[_local_5];
                    if (_local_9 != _local_4.fillStyleIdx)
                    {
                        if (_local_9 != 0xFFFFFFFF)
                        {
                            _arg_1.endFill();
                        };
                        _local_9 = _local_4.fillStyleIdx;
                        _local_11 = new Point(1.79769313486232E308, 1.79769313486232E308);
                        try
                        {
                            _local_14 = _SafeStr_704[(_local_9 - 1)];
                            switch (_local_14.type)
                            {
                                case 0:
                                    _arg_1.beginFill(ColorUtils.rgb(_local_14.rgb), ColorUtils.alpha(_local_14.rgb));
                                    break;
                                case 16:
                                case 18:
                                case 19:
                                    _local_8 = [];
                                    _local_13 = [];
                                    _local_15 = [];
                                    _local_6 = _local_14._SafeStr_311.matrix.clone();
                                    _local_6.tx = (_local_6.tx / 20);
                                    _local_6.ty = (_local_6.ty / 20);
                                    _local_16 = 0;
                                    while (_local_16 < _local_14._SafeStr_312.records.length)
                                    {
                                        _local_12 = _local_14._SafeStr_312.records[_local_16];
                                        _local_8.push(ColorUtils.rgb(_local_12.color));
                                        _local_13.push(ColorUtils.alpha(_local_12.color));
                                        _local_15.push(_local_12._SafeStr_286);
                                        _local_16++;
                                    };
                                    _arg_1.beginGradientFill(((_local_14.type == 16) ? "linear" : "radial"), _local_8, _local_13, _local_15, _local_6, _SafeStr_94.toString(_local_14._SafeStr_312._SafeStr_313), _SafeStr_87.toString(_local_14._SafeStr_312.interpolationMode), _local_14._SafeStr_312.focalPoint);
                                    break;
                                case 64:
                                case 65:
                                case 66:
                                case 67:
                                    _local_7 = _local_14._SafeStr_314;
                                    _local_6 = new Matrix();
                                    _local_6.createBox((_local_7._SafeStr_315 / 20), (_local_7._SafeStr_316 / 20), _local_7.rotation, (_local_7._SafeStr_290 / 20), (_local_7._SafeStr_291 / 20));
                                    _arg_1.beginBitmapFill(_local_14._SafeStr_317, _local_6, ((_local_14.type == 64) || (_local_14.type == 66)), ((_local_14.type == 64) || (_local_14.type == 65)));
                            };
                        }
                        catch(e:Error)
                        {
                            _arg_1.beginFill(0);
                        };
                    };
                    if (!_local_11.equals(_local_4.from))
                    {
                        _arg_1.moveTo(_local_4.from.x, _local_4.from.y);
                    };
                    if ((_local_4 is CurvedEdge))
                    {
                        _local_3 = CurvedEdge(_local_4);
                        _arg_1.curveTo(_local_3.control.x, _local_3.control.y, _local_3.to.x, _local_3.to.y);
                    }
                    else
                    {
                        _arg_1.lineTo(_local_4.to.x, _local_4.to.y);
                    };
                    _local_11 = _local_4.to;
                    _local_5++;
                };
                if (_local_9 != 0xFFFFFFFF)
                {
                    _arg_1.endFill();
                };
                _arg_1.endFills();
            };
        }

        protected function exportLinePath(_arg_1:IShapeExporter, _arg_2:uint):void
        {
            var _local_10:SWFLineStyle;
            var _local_6:uint;
            var _local_5:IEdge;
            var _local_3:String;
            var _local_14:SWFFillStyle;
            var _local_8:Array;
            var _local_13:Array;
            var _local_16:Array;
            var _local_12:SWFGradientRecord;
            var _local_7:Matrix;
            var _local_17:uint;
            var _local_4:CurvedEdge;
            var _local_9:Vector.<IEdge> = createPathFromEdgeMap(lineEdgeMaps[_arg_2]);
            var _local_11:Point = new Point(1.79769313486232E308, 1.79769313486232E308);
            var _local_15:int = 0xFFFFFFFF;
            if (_local_9.length > 0)
            {
                _arg_1.beginLines();
                _local_6 = 0;
                while (_local_6 < _local_9.length)
                {
                    _local_5 = _local_9[_local_6];
                    if (_local_15 != _local_5.lineStyleIdx)
                    {
                        _local_15 = _local_5.lineStyleIdx;
                        _local_11 = new Point(1.79769313486232E308, 1.79769313486232E308);
                        try
                        {
                            _local_10 = _SafeStr_705[(_local_15 - 1)];
                        }
                        catch(e:Error)
                        {
                            _local_10 = null;
                        };
                        if (_local_10 != null)
                        {
                            _local_3 = "normal";
                            if (((_local_10.noHScaleFlag) && (_local_10.noVScaleFlag)))
                            {
                                _local_3 = "none";
                            }
                            else
                            {
                                if (_local_10.noHScaleFlag)
                                {
                                    _local_3 = "horizontal";
                                }
                                else
                                {
                                    if (_local_10.noVScaleFlag)
                                    {
                                        _local_3 = "vertical";
                                    };
                                };
                            };
                            _arg_1.lineStyle((_local_10.width / 20), ColorUtils.rgb(_local_10.color), ColorUtils.alpha(_local_10.color), _local_10.pixelHintingFlag, _local_3, _SafeStr_86.toString(_local_10._SafeStr_318), _SafeStr_86.toString(_local_10.endCapsStyle), _SafeStr_89.toString(_local_10.jointStyle), _local_10.miterLimitFactor);
                            if (_local_10.hasFillFlag)
                            {
                                _local_14 = _local_10.fillType;
                                switch (_local_14.type)
                                {
                                    case 16:
                                    case 18:
                                    case 19:
                                        _local_8 = [];
                                        _local_13 = [];
                                        _local_16 = [];
                                        _local_7 = _local_14._SafeStr_311.matrix.clone();
                                        _local_7.tx = (_local_7.tx / 20);
                                        _local_7.ty = (_local_7.ty / 20);
                                        _local_17 = 0;
                                        while (_local_17 < _local_14._SafeStr_312.records.length)
                                        {
                                            _local_12 = _local_14._SafeStr_312.records[_local_17];
                                            _local_8.push(ColorUtils.rgb(_local_12.color));
                                            _local_13.push(ColorUtils.alpha(_local_12.color));
                                            _local_16.push(_local_12._SafeStr_286);
                                            _local_17++;
                                        };
                                        _arg_1.lineGradientStyle(((_local_14.type == 16) ? "linear" : "radial"), _local_8, _local_13, _local_16, _local_7, _SafeStr_94.toString(_local_14._SafeStr_312._SafeStr_313), _SafeStr_87.toString(_local_14._SafeStr_312.interpolationMode), _local_14._SafeStr_312.focalPoint);
                                    default:
                                };
                            };
                        }
                        else
                        {
                            _arg_1.lineStyle(0);
                        };
                    };
                    if (!_local_5.from.equals(_local_11))
                    {
                        _arg_1.moveTo(_local_5.from.x, _local_5.from.y);
                    };
                    if ((_local_5 is CurvedEdge))
                    {
                        _local_4 = CurvedEdge(_local_5);
                        _arg_1.curveTo(_local_4.control.x, _local_4.control.y, _local_4.to.x, _local_4.to.y);
                    }
                    else
                    {
                        _arg_1.lineTo(_local_5.to.x, _local_5.to.y);
                    };
                    _local_11 = _local_5.to;
                    _local_6++;
                };
                _arg_1.endLines();
            };
        }

        protected function createPathFromEdgeMap(_arg_1:Dictionary):Vector.<IEdge>
        {
            var _local_3:uint;
            var _local_4:Vector.<IEdge> = new Vector.<IEdge>();
            var _local_5:Array = [];
            for (var _local_2:String in _arg_1)
            {
                _local_5.push(parseInt(_local_2));
            };
            _local_5.sort(16);
            _local_3 = 0;
            while (_local_3 < _local_5.length)
            {
                appendEdges(_local_4, (_arg_1[_local_5[_local_3]] as Vector.<IEdge>));
                _local_3++;
            };
            return (_local_4);
        }

        protected function cleanEdgeMap(_arg_1:Dictionary):void
        {
            var _local_5:Vector.<IEdge> = undefined;
            var _local_6:uint;
            var _local_3:IEdge;
            var _local_7:Vector.<IEdge> = undefined;
            var _local_2:IEdge;
            for (var _local_4:String in _arg_1)
            {
                _local_5 = (_arg_1[_local_4] as Vector.<IEdge>);
                if (((_local_5) && (_local_5.length > 0)))
                {
                    _local_7 = new Vector.<IEdge>();
                    createCoordMap(_local_5);
                    while (_local_5.length > 0)
                    {
                        _local_6 = 0;
                        while (_local_6 < _local_5.length)
                        {
                            if (((_local_3 == null) || (_local_3.to.equals(_local_5[_local_6].from))))
                            {
                                _local_2 = _local_5.splice(_local_6, 1)[0];
                                _local_7.push(_local_2);
                                removeEdgeFromCoordMap(_local_2);
                                _local_3 = _local_2;
                            }
                            else
                            {
                                _local_2 = findNextEdgeInCoordMap(_local_3);
                                if (_local_2)
                                {
                                    _local_6 = _local_5.indexOf(_local_2);
                                }
                                else
                                {
                                    _local_6 = 0;
                                    _local_3 = null;
                                };
                            };
                        };
                    };
                    _arg_1[_local_4] = _local_7;
                };
            };
        }

        protected function createCoordMap(_arg_1:Vector.<IEdge>):void
        {
            var _local_3:uint;
            var _local_4:Point;
            var _local_5:String;
            var _local_2:Array;
            _SafeStr_707 = new Dictionary();
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3].from;
                _local_5 = ((_local_4.x + "_") + _local_4.y);
                _local_2 = (_SafeStr_707[_local_5] as Array);
                if (_local_2 == null)
                {
                    _SafeStr_707[_local_5] = [_arg_1[_local_3]];
                }
                else
                {
                    _local_2.push(_arg_1[_local_3]);
                };
                _local_3++;
            };
        }

        protected function removeEdgeFromCoordMap(_arg_1:IEdge):void
        {
            var _local_3:int;
            var _local_4:String = ((_arg_1.from.x + "_") + _arg_1.from.y);
            var _local_2:Array = (_SafeStr_707[_local_4] as Array);
            if (_local_2)
            {
                if (_local_2.length == 1)
                {
                    delete _SafeStr_707[_local_4];
                }
                else
                {
                    _local_3 = _local_2.indexOf(_arg_1);
                    if (_local_3 > -1)
                    {
                        _local_2.splice(_local_3, 1);
                    };
                };
            };
        }

        protected function findNextEdgeInCoordMap(_arg_1:IEdge):IEdge
        {
            var _local_3:String = ((_arg_1.to.x + "_") + _arg_1.to.y);
            var _local_2:Array = (_SafeStr_707[_local_3] as Array);
            if (((_local_2) && (_local_2.length > 0)))
            {
                return (_local_2[0] as IEdge);
            };
            return (null);
        }

        protected function appendFillStyles(_arg_1:Vector.<SWFFillStyle>, _arg_2:Vector.<SWFFillStyle>):void
        {
            var _local_3:uint;
            _local_3 = 0;
            while (_local_3 < _arg_2.length)
            {
                _arg_1.push(_arg_2[_local_3]);
                _local_3++;
            };
        }

        protected function appendLineStyles(_arg_1:Vector.<SWFLineStyle>, _arg_2:Vector.<SWFLineStyle>):void
        {
            var _local_3:uint;
            _local_3 = 0;
            while (_local_3 < _arg_2.length)
            {
                _arg_1.push(_arg_2[_local_3]);
                _local_3++;
            };
        }

        protected function appendEdges(_arg_1:Vector.<IEdge>, _arg_2:Vector.<IEdge>):void
        {
            var _local_3:uint;
            _local_3 = 0;
            while (_local_3 < _arg_2.length)
            {
                _arg_1.push(_arg_2[_local_3]);
                _local_3++;
            };
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = (("\n" + StringUtils.repeat(_arg_1)) + "ShapeRecords:");
            _local_3 = 0;
            while (_local_3 < _SafeStr_703.length)
            {
                _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] ") + _SafeStr_703[_local_3].toString((_arg_1 + 2))));
                _local_3++;
            };
            return (_local_2);
        }


    }
}


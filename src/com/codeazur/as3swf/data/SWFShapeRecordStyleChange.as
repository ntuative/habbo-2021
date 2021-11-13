package com.codeazur.as3swf.data
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class SWFShapeRecordStyleChange extends SWFShapeRecord 
    {

        public var _SafeStr_309:Boolean = false;
        public var _SafeStr_310:Boolean = false;
        public var stateFillStyle1:Boolean = false;
        public var stateFillStyle0:Boolean = false;
        public var stateMoveTo:Boolean = false;
        public var moveDeltaX:int = 0;
        public var moveDeltaY:int = 0;
        public var fillStyle0:uint = 0;
        public var fillStyle1:uint = 0;
        public var lineStyle:uint = 0;
        public var _SafeStr_292:uint = 0;
        public var _SafeStr_293:uint = 0;
        protected var _SafeStr_704:Vector.<SWFFillStyle> = new Vector.<SWFFillStyle>();
        protected var _SafeStr_705:Vector.<SWFLineStyle> = new Vector.<SWFLineStyle>();

        public function SWFShapeRecordStyleChange(_arg_1:SWFData=null, _arg_2:uint=0, _arg_3:uint=0, _arg_4:uint=0, _arg_5:uint=1)
        {
            _SafeStr_309 = (!((_arg_2 & 0x10) == 0));
            _SafeStr_310 = (!((_arg_2 & 0x08) == 0));
            stateFillStyle1 = (!((_arg_2 & 0x04) == 0));
            stateFillStyle0 = (!((_arg_2 & 0x02) == 0));
            stateMoveTo = (!((_arg_2 & 0x01) == 0));
            _SafeStr_292 = _arg_3;
            _SafeStr_293 = _arg_4;
            super(_arg_1, _arg_5);
        }

        public function get fillStyles():Vector.<SWFFillStyle>
        {
            return (_SafeStr_704);
        }

        public function get lineStyles():Vector.<SWFLineStyle>
        {
            return (_SafeStr_705);
        }

        override public function get type():uint
        {
            return (2);
        }

        override public function parse(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_3:uint;
            var _local_4:uint;
            if (stateMoveTo)
            {
                _local_5 = _arg_1.readUB(5);
                moveDeltaX = _arg_1.readSB(_local_5);
                moveDeltaY = _arg_1.readSB(_local_5);
            };
            fillStyle0 = ((stateFillStyle0) ? _arg_1.readUB(_SafeStr_292) : 0);
            fillStyle1 = ((stateFillStyle1) ? _arg_1.readUB(_SafeStr_292) : 0);
            lineStyle = ((_SafeStr_310) ? _arg_1.readUB(_SafeStr_293) : 0);
            if (_SafeStr_309)
            {
                _arg_1.resetBitsPending();
                _local_3 = readStyleArrayLength(_arg_1, _arg_2);
                _local_6 = 0;
                while (_local_6 < _local_3)
                {
                    fillStyles.push(_arg_1.readFILLSTYLE(_arg_2));
                    _local_6++;
                };
                _local_4 = readStyleArrayLength(_arg_1, _arg_2);
                _local_6 = 0;
                while (_local_6 < _local_4)
                {
                    lineStyles.push(((_arg_2 <= 3) ? _arg_1.readLINESTYLE(_arg_2) : _arg_1.readLINESTYLE2(_arg_2)));
                    _local_6++;
                };
                _SafeStr_292 = _arg_1.readUB(4);
                _SafeStr_293 = _arg_1.readUB(4);
            };
        }

        override public function publish(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_3:uint;
            var _local_4:uint;
            if (stateMoveTo)
            {
                _local_5 = _arg_1.calculateMaxBits(true, [moveDeltaX, moveDeltaY]);
                _arg_1.writeUB(5, _local_5);
                _arg_1.writeSB(_local_5, moveDeltaX);
                _arg_1.writeSB(_local_5, moveDeltaY);
            };
            if (stateFillStyle0)
            {
                _arg_1.writeUB(_SafeStr_292, fillStyle0);
            };
            if (stateFillStyle1)
            {
                _arg_1.writeUB(_SafeStr_292, fillStyle1);
            };
            if (_SafeStr_310)
            {
                _arg_1.writeUB(_SafeStr_293, lineStyle);
            };
            if (_SafeStr_309)
            {
                _arg_1.resetBitsPending();
                _local_3 = fillStyles.length;
                writeStyleArrayLength(_arg_1, _local_3, _arg_2);
                _local_6 = 0;
                while (_local_6 < _local_3)
                {
                    fillStyles[_local_6].publish(_arg_1, _arg_2);
                    _local_6++;
                };
                _local_4 = lineStyles.length;
                writeStyleArrayLength(_arg_1, _local_4, _arg_2);
                _local_6 = 0;
                while (_local_6 < _local_4)
                {
                    lineStyles[_local_6].publish(_arg_1, _arg_2);
                    _local_6++;
                };
                _SafeStr_292 = _arg_1.calculateMaxBits(false, [_local_3]);
                _SafeStr_293 = _arg_1.calculateMaxBits(false, [_local_4]);
                _arg_1.writeUB(4, _SafeStr_292);
                _arg_1.writeUB(4, _SafeStr_293);
            };
        }

        protected function readStyleArrayLength(_arg_1:SWFData, _arg_2:uint=1):uint
        {
            var _local_3:uint = _arg_1.readUI8();
            if (((_arg_2 >= 2) && (_local_3 == 0xFF)))
            {
                _local_3 = _arg_1.readUI16();
            };
            return (_local_3);
        }

        protected function writeStyleArrayLength(_arg_1:SWFData, _arg_2:uint, _arg_3:uint=1):void
        {
            if (((_arg_3 >= 2) && (_arg_2 > 254)))
            {
                _arg_1.writeUI8(0xFF);
                _arg_1.writeUI16(_arg_2);
            }
            else
            {
                _arg_1.writeUI8(_arg_2);
            };
        }

        override public function clone():SWFShapeRecord
        {
            var _local_2:uint;
            var _local_1:SWFShapeRecordStyleChange = new SWFShapeRecordStyleChange();
            _local_1._SafeStr_309 = _SafeStr_309;
            _local_1._SafeStr_310 = _SafeStr_310;
            _local_1.stateFillStyle1 = stateFillStyle1;
            _local_1.stateFillStyle0 = stateFillStyle0;
            _local_1.stateMoveTo = stateMoveTo;
            _local_1.moveDeltaX = moveDeltaX;
            _local_1.moveDeltaY = moveDeltaY;
            _local_1.fillStyle0 = fillStyle0;
            _local_1.fillStyle1 = fillStyle1;
            _local_1.lineStyle = lineStyle;
            _local_1._SafeStr_292 = _SafeStr_292;
            _local_1._SafeStr_293 = _SafeStr_293;
            _local_2 = 0;
            while (_local_2 < fillStyles.length)
            {
                _local_1.fillStyles.push(fillStyles[_local_2].clone());
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < lineStyles.length)
            {
                _local_1.lineStyles.push(lineStyles[_local_2].clone());
                _local_2++;
            };
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_2:String = "[SWFShapeRecordStyleChange] ";
            var _local_3:Array = [];
            if (stateMoveTo)
            {
                _local_3.push(((("MoveTo: " + moveDeltaX) + ",") + moveDeltaY));
            };
            if (stateFillStyle0)
            {
                _local_3.push(("FillStyle0: " + fillStyle0));
            };
            if (stateFillStyle1)
            {
                _local_3.push(("FillStyle1: " + fillStyle1));
            };
            if (_SafeStr_310)
            {
                _local_3.push(("LineStyle: " + lineStyle));
            };
            if (_local_3.length > 0)
            {
                _local_2 = (_local_2 + _local_3.join(", "));
            };
            if (_SafeStr_309)
            {
                if (_SafeStr_704.length > 0)
                {
                    _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "New FillStyles:"));
                    _local_4 = 0;
                    while (_local_4 < _SafeStr_704.length)
                    {
                        _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + (_local_4 + 1)) + "] ") + _SafeStr_704[_local_4].toString()));
                        _local_4++;
                    };
                };
                if (_SafeStr_705.length > 0)
                {
                    _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "New LineStyles:"));
                    _local_4 = 0;
                    while (_local_4 < _SafeStr_705.length)
                    {
                        _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + (_local_4 + 1)) + "] ") + _SafeStr_705[_local_4].toString()));
                        _local_4++;
                    };
                };
            };
            return (_local_2);
        }


    }
}


package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFShapeRecordStraightEdge extends SWFShapeRecord 
    {

        public var _SafeStr_303:Boolean;
        public var _SafeStr_304:Boolean;
        public var _SafeStr_302:int;
        public var _SafeStr_301:int;
        protected var _SafeStr_711:uint;

        public function SWFShapeRecordStraightEdge(_arg_1:SWFData=null, _arg_2:uint=0, _arg_3:uint=1)
        {
            this._SafeStr_711 = _arg_2;
            super(_arg_1, _arg_3);
        }

        override public function parse(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            _SafeStr_303 = (_arg_1.readUB(1) == 1);
            _SafeStr_304 = ((_SafeStr_303) ? false : (_arg_1.readUB(1) == 1));
            _SafeStr_301 = (((_SafeStr_303) || (!(_SafeStr_304))) ? _arg_1.readSB(_SafeStr_711) : 0);
            _SafeStr_302 = (((_SafeStr_303) || (_SafeStr_304)) ? _arg_1.readSB(_SafeStr_711) : 0);
        }

        override public function publish(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            var _local_3:uint;
            var _local_4:Array = [];
            if (((_SafeStr_303) || (!(_SafeStr_304))))
            {
                _local_4.push(_SafeStr_301);
            };
            if (((_SafeStr_303) || (_SafeStr_304)))
            {
                _local_4.push(_SafeStr_302);
            };
            _SafeStr_711 = _arg_1.calculateMaxBits(true, _local_4);
            if (_SafeStr_711 < 2)
            {
                _SafeStr_711 = 2;
            };
            _arg_1.writeUB(4, (_SafeStr_711 - 2));
            _arg_1.writeUB(1, ((_SafeStr_303) ? 1 : 0));
            if (!_SafeStr_303)
            {
                _arg_1.writeUB(1, ((_SafeStr_304) ? 1 : 0));
            };
            _local_3 = 0;
            while (_local_3 < _local_4.length)
            {
                _arg_1.writeSB(_SafeStr_711, _local_4[_local_3]);
                _local_3++;
            };
        }

        override public function clone():SWFShapeRecord
        {
            var _local_1:SWFShapeRecordStraightEdge = new SWFShapeRecordStraightEdge();
            _local_1._SafeStr_301 = _SafeStr_301;
            _local_1._SafeStr_302 = _SafeStr_302;
            _local_1._SafeStr_303 = _SafeStr_303;
            _local_1._SafeStr_304 = _SafeStr_304;
            _local_1._SafeStr_711 = _SafeStr_711;
            return (_local_1);
        }

        override public function get type():uint
        {
            return (3);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = "[SWFShapeRecordStraightEdge] ";
            if (_SafeStr_303)
            {
                _local_2 = (_local_2 + ((("General: " + _SafeStr_301) + ",") + _SafeStr_302));
            }
            else
            {
                if (_SafeStr_304)
                {
                    _local_2 = (_local_2 + ("Vertical: " + _SafeStr_302));
                }
                else
                {
                    _local_2 = (_local_2 + ("Horizontal: " + _SafeStr_301));
                };
            };
            return (_local_2);
        }


    }
}


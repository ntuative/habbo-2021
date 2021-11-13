package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFShapeRecordCurvedEdge extends SWFShapeRecord 
    {

        public var controlDeltaX:int;
        public var controlDeltaY:int;
        public var _SafeStr_305:int;
        public var _SafeStr_306:int;
        protected var _SafeStr_711:uint;

        public function SWFShapeRecordCurvedEdge(_arg_1:SWFData=null, _arg_2:uint=0, _arg_3:uint=1)
        {
            this._SafeStr_711 = _arg_2;
            super(_arg_1, _arg_3);
        }

        override public function parse(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            controlDeltaX = _arg_1.readSB(_SafeStr_711);
            controlDeltaY = _arg_1.readSB(_SafeStr_711);
            _SafeStr_305 = _arg_1.readSB(_SafeStr_711);
            _SafeStr_306 = _arg_1.readSB(_SafeStr_711);
        }

        override public function publish(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
            _SafeStr_711 = _arg_1.calculateMaxBits(true, [controlDeltaX, controlDeltaY, _SafeStr_305, _SafeStr_306]);
            if (_SafeStr_711 < 2)
            {
                _SafeStr_711 = 2;
            };
            _arg_1.writeUB(4, (_SafeStr_711 - 2));
            _arg_1.writeSB(_SafeStr_711, controlDeltaX);
            _arg_1.writeSB(_SafeStr_711, controlDeltaY);
            _arg_1.writeSB(_SafeStr_711, _SafeStr_305);
            _arg_1.writeSB(_SafeStr_711, _SafeStr_306);
        }

        override public function clone():SWFShapeRecord
        {
            var _local_1:SWFShapeRecordCurvedEdge = new SWFShapeRecordCurvedEdge();
            _local_1._SafeStr_305 = _SafeStr_305;
            _local_1._SafeStr_306 = _SafeStr_306;
            _local_1.controlDeltaX = controlDeltaX;
            _local_1.controlDeltaY = controlDeltaY;
            _local_1._SafeStr_711 = _SafeStr_711;
            return (_local_1);
        }

        override public function get type():uint
        {
            return (4);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return (((((((("[SWFShapeRecordCurvedEdge] ControlDelta: " + controlDeltaX) + ",") + controlDeltaY) + ", ") + "AnchorDelta: ") + _SafeStr_305) + ",") + _SafeStr_306);
        }


    }
}


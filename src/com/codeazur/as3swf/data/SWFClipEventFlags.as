package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFClipEventFlags 
    {

        public var keyUpEvent:Boolean;
        public var keyDownEvent:Boolean;
        public var _SafeStr_357:Boolean;
        public var mouseDownEvent:Boolean;
        public var _SafeStr_358:Boolean;
        public var _SafeStr_359:Boolean;
        public var enterFrameEvent:Boolean;
        public var _SafeStr_360:Boolean;
        public var _SafeStr_361:Boolean;
        public var rollOutEvent:Boolean;
        public var rollOverEvent:Boolean;
        public var _SafeStr_362:Boolean;
        public var _SafeStr_363:Boolean;
        public var pressEvent:Boolean;
        public var initializeEvent:Boolean;
        public var _SafeStr_364:Boolean;
        public var constructEvent:Boolean;
        public var _SafeStr_365:Boolean;
        public var _SafeStr_366:Boolean;

        public function SWFClipEventFlags(_arg_1:SWFData=null, _arg_2:uint=0)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function parse(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_5:uint = _arg_1.readUI8();
            keyUpEvent = (!((_local_5 & 0x80) == 0));
            keyDownEvent = (!((_local_5 & 0x40) == 0));
            _SafeStr_357 = (!((_local_5 & 0x20) == 0));
            mouseDownEvent = (!((_local_5 & 0x10) == 0));
            _SafeStr_358 = (!((_local_5 & 0x08) == 0));
            _SafeStr_359 = (!((_local_5 & 0x04) == 0));
            enterFrameEvent = (!((_local_5 & 0x02) == 0));
            _SafeStr_360 = (!((_local_5 & 0x01) == 0));
            var _local_4:uint = _arg_1.readUI8();
            _SafeStr_361 = (!((_local_4 & 0x80) == 0));
            rollOutEvent = (!((_local_4 & 0x40) == 0));
            rollOverEvent = (!((_local_4 & 0x20) == 0));
            _SafeStr_362 = (!((_local_4 & 0x10) == 0));
            _SafeStr_363 = (!((_local_4 & 0x08) == 0));
            pressEvent = (!((_local_4 & 0x04) == 0));
            initializeEvent = (!((_local_4 & 0x02) == 0));
            _SafeStr_364 = (!((_local_4 & 0x01) == 0));
            if (_arg_2 >= 6)
            {
                _local_3 = _arg_1.readUI8();
                constructEvent = (!((_local_3 & 0x04) == 0));
                _SafeStr_365 = (!((_local_3 & 0x02) == 0));
                _SafeStr_366 = (!((_local_3 & 0x01) == 0));
                _arg_1.readUI8();
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:uint;
            var _local_5:uint;
            if (keyUpEvent)
            {
                _local_5 = (_local_5 | 0x80);
            };
            if (keyDownEvent)
            {
                _local_5 = (_local_5 | 0x40);
            };
            if (_SafeStr_357)
            {
                _local_5 = (_local_5 | 0x20);
            };
            if (mouseDownEvent)
            {
                _local_5 = (_local_5 | 0x10);
            };
            if (_SafeStr_358)
            {
                _local_5 = (_local_5 | 0x08);
            };
            if (_SafeStr_359)
            {
                _local_5 = (_local_5 | 0x04);
            };
            if (enterFrameEvent)
            {
                _local_5 = (_local_5 | 0x02);
            };
            if (_SafeStr_360)
            {
                _local_5 = (_local_5 | 0x01);
            };
            _arg_1.writeUI8(_local_5);
            var _local_4:uint;
            if (_SafeStr_361)
            {
                _local_4 = (_local_4 | 0x80);
            };
            if (rollOutEvent)
            {
                _local_4 = (_local_4 | 0x40);
            };
            if (rollOverEvent)
            {
                _local_4 = (_local_4 | 0x20);
            };
            if (_SafeStr_362)
            {
                _local_4 = (_local_4 | 0x10);
            };
            if (_SafeStr_363)
            {
                _local_4 = (_local_4 | 0x08);
            };
            if (pressEvent)
            {
                _local_4 = (_local_4 | 0x04);
            };
            if (initializeEvent)
            {
                _local_4 = (_local_4 | 0x02);
            };
            if (_SafeStr_364)
            {
                _local_4 = (_local_4 | 0x01);
            };
            _arg_1.writeUI8(_local_4);
            if (_arg_2 >= 6)
            {
                _local_3 = 0;
                if (constructEvent)
                {
                    _local_3 = (_local_3 | 0x04);
                };
                if (_SafeStr_365)
                {
                    _local_3 = (_local_3 | 0x02);
                };
                if (_SafeStr_366)
                {
                    _local_3 = (_local_3 | 0x01);
                };
                _arg_1.writeUI8(_local_3);
                _arg_1.writeUI8(0);
            };
        }

        public function toString():String
        {
            var _local_1:Array = [];
            if (keyUpEvent)
            {
                _local_1.push("keyup");
            };
            if (keyDownEvent)
            {
                _local_1.push("keydown");
            };
            if (_SafeStr_357)
            {
                _local_1.push("mouseup");
            };
            if (mouseDownEvent)
            {
                _local_1.push("mousedown");
            };
            if (_SafeStr_358)
            {
                _local_1.push("mousemove");
            };
            if (_SafeStr_359)
            {
                _local_1.push("unload");
            };
            if (enterFrameEvent)
            {
                _local_1.push("enterframe");
            };
            if (_SafeStr_360)
            {
                _local_1.push("load");
            };
            if (_SafeStr_361)
            {
                _local_1.push("dragover");
            };
            if (rollOutEvent)
            {
                _local_1.push("rollout");
            };
            if (rollOverEvent)
            {
                _local_1.push("rollover");
            };
            if (_SafeStr_362)
            {
                _local_1.push("releaseoutside");
            };
            if (_SafeStr_363)
            {
                _local_1.push("release");
            };
            if (pressEvent)
            {
                _local_1.push("press");
            };
            if (initializeEvent)
            {
                _local_1.push("initialize");
            };
            if (_SafeStr_364)
            {
                _local_1.push("data");
            };
            if (constructEvent)
            {
                _local_1.push("construct");
            };
            if (_SafeStr_365)
            {
                _local_1.push("keypress");
            };
            if (_SafeStr_366)
            {
                _local_1.push("dragout");
            };
            return (_local_1.join(","));
        }


    }
}


package com.codeazur.as3swf.timeline
{
    import com.codeazur.utils.StringUtils;

    public class Layer 
    {

        public var depth:uint = 0;
        public var frameCount:uint = 0;
        public var _SafeStr_307:Array;
        public var _SafeStr_308:Array;

        public function Layer(_arg_1:uint, _arg_2:uint)
        {
            this.depth = _arg_1;
            this.frameCount = _arg_2;
            _SafeStr_307 = [];
            _SafeStr_308 = [];
        }

        public function appendStrip(_arg_1:uint, _arg_2:uint, _arg_3:uint):void
        {
            var _local_5:uint;
            var _local_4:uint;
            var _local_6:LayerStrip;
            if (_arg_1 != 0)
            {
                _local_4 = _SafeStr_308.length;
                if (((_local_4 == 0) && (_arg_2 > 0)))
                {
                    _local_5 = 0;
                    while (_local_5 < _arg_2)
                    {
                        _SafeStr_307[_local_5] = _local_4;
                        _local_5++;
                    };
                    _SafeStr_308[_local_4++] = new LayerStrip(1, 0, (_arg_2 - 1));
                }
                else
                {
                    if (_local_4 > 0)
                    {
                        _local_6 = (_SafeStr_308[(_local_4 - 1)] as LayerStrip);
                        if ((_local_6.endFrameIndex + 1) < _arg_2)
                        {
                            _local_5 = (_local_6.endFrameIndex + 1);
                            while (_local_5 < _arg_2)
                            {
                                _SafeStr_307[_local_5] = _local_4;
                                _local_5++;
                            };
                            _SafeStr_308[_local_4++] = new LayerStrip(1, (_local_6.endFrameIndex + 1), (_arg_2 - 1));
                        };
                    };
                };
                _local_5 = _arg_2;
                while (_local_5 <= _arg_3)
                {
                    _SafeStr_307[_local_5] = _local_4;
                    _local_5++;
                };
                _SafeStr_308[_local_4] = new LayerStrip(_arg_1, _arg_2, _arg_3);
            };
        }

        public function getStripsForFrameRegion(_arg_1:uint, _arg_2:uint):Array
        {
            if (((_arg_1 >= _SafeStr_307.length) || (_arg_2 < _arg_1)))
            {
                return ([]);
            };
            var _local_3:uint = _SafeStr_307[_arg_1];
            var _local_4:uint = ((_arg_2 >= _SafeStr_307.length) ? (_SafeStr_308.length - 1) : _SafeStr_307[_arg_2]);
            return (_SafeStr_308.slice(_local_3, (_local_4 + 1)));
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_4:uint;
            var _local_3:LayerStrip;
            var _local_2:String = ((("Depth: " + depth) + ", Frames: ") + frameCount);
            if (_SafeStr_308.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Strips:"));
                _local_4 = 0;
                while (_local_4 < _SafeStr_308.length)
                {
                    _local_3 = (_SafeStr_308[_local_4] as LayerStrip);
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_4) + "] ") + _local_3.toString()));
                    _local_4++;
                };
            };
            return (_local_2);
        }


    }
}


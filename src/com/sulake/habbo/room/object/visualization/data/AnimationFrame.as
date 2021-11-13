package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrame 
    {

        public static const FRAME_REPEAT_FOREVER:int = -1;
        public static const _SafeStr_3275:int = -1;
        private static const POOL_SIZE_LIMIT:int = 3000;
        private static const _SafeStr_1036:Array = [];

        private var _SafeStr_698:int = 0;
        private var _x:int = 0;
        private var _y:int = 0;
        private var _repeats:int = 1;
        private var _frameRepeats:int = 1;
        private var _SafeStr_3276:int = 1;
        private var _activeSequence:int = -1;
        private var _activeSequenceOffset:int = 0;
        private var _isLastFrame:Boolean = false;
        private var _SafeStr_3277:Boolean = false;


        public static function allocate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:int=-1, _arg_8:int=0):AnimationFrame
        {
            var _local_9:AnimationFrame = ((_SafeStr_1036.length > 0) ? _SafeStr_1036.pop() : new AnimationFrame());
            _local_9._SafeStr_3277 = false;
            _local_9._SafeStr_698 = _arg_1;
            _local_9._x = _arg_2;
            _local_9._y = _arg_3;
            _local_9._isLastFrame = _arg_6;
            if (_arg_4 < 1)
            {
                _arg_4 = 1;
            };
            _local_9._repeats = _arg_4;
            if (_arg_5 < 0)
            {
                _arg_5 = -1;
            };
            _local_9._frameRepeats = _arg_5;
            _local_9._SafeStr_3276 = _arg_5;
            if (_arg_7 >= 0)
            {
                _local_9._activeSequence = _arg_7;
                _local_9._activeSequenceOffset = _arg_8;
            };
            return (_local_9);
        }


        public function get id():int
        {
            if (_SafeStr_698 >= 0)
            {
                return (_SafeStr_698);
            };
            return (-(_SafeStr_698) * Math.random());
        }

        public function get x():int
        {
            return (_x);
        }

        public function get y():int
        {
            return (_y);
        }

        public function get repeats():int
        {
            return (_repeats);
        }

        public function get frameRepeats():int
        {
            return (_frameRepeats);
        }

        public function get isLastFrame():Boolean
        {
            return (_isLastFrame);
        }

        public function get remainingFrameRepeats():int
        {
            if (_frameRepeats < 0)
            {
                return (-1);
            };
            return (_SafeStr_3276);
        }

        public function set remainingFrameRepeats(_arg_1:int):void
        {
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (((_frameRepeats > 0) && (_arg_1 > _frameRepeats)))
            {
                _arg_1 = _frameRepeats;
            };
            _SafeStr_3276 = _arg_1;
        }

        public function get activeSequence():int
        {
            return (_activeSequence);
        }

        public function get activeSequenceOffset():int
        {
            return (_activeSequenceOffset);
        }

        public function recycle():void
        {
            if (!_SafeStr_3277)
            {
                _SafeStr_3277 = true;
                if (_SafeStr_1036.length < 3000)
                {
                    _SafeStr_1036.push(this);
                };
            };
        }


    }
}


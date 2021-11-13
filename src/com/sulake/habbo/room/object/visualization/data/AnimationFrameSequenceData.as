package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrameSequenceData 
    {

        private var _SafeStr_748:Array = [];
        private var _SafeStr_1347:Array = [];
        private var _SafeStr_3279:Array = [];
        private var _isRandom:Boolean = false;
        private var _SafeStr_3280:int = 1;

        public function AnimationFrameSequenceData(_arg_1:int, _arg_2:Boolean)
        {
            if (_arg_1 < 1)
            {
                _arg_1 = 1;
            };
            _SafeStr_3280 = _arg_1;
            _isRandom = _arg_2;
        }

        public function get isRandom():Boolean
        {
            return (_isRandom);
        }

        public function get frameCount():int
        {
            return (_SafeStr_1347.length * _SafeStr_3280);
        }

        public function dispose():void
        {
            _SafeStr_748 = [];
        }

        public function initialize():void
        {
            var _local_3:int;
            var _local_1:int = 1;
            var _local_2:int = -1;
            _local_3 = (_SafeStr_1347.length - 1);
            while (_local_3 >= 0)
            {
                if (_SafeStr_1347[_local_3] == _local_2)
                {
                    _local_1++;
                }
                else
                {
                    _local_2 = _SafeStr_1347[_local_3];
                    _local_1 = 1;
                };
                _SafeStr_3279[_local_3] = _local_1;
                _local_3--;
            };
        }

        public function addFrame(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:DirectionalOffsetData):void
        {
            var _local_8:AnimationFrameData;
            var _local_7:int = 1;
            if (_SafeStr_748.length > 0)
            {
                _local_8 = _SafeStr_748[(_SafeStr_748.length - 1)];
                if (((((((((_local_8.id == _arg_1) && (!(_local_8.hasDirectionalOffsets()))) && (_local_8.x == _arg_2)) && (_local_8.y == _arg_3)) && (_local_8.randomX == _arg_4)) && (_arg_4 == 0)) && (_local_8.randomY == _arg_5)) && (_arg_5 == 0)))
                {
                    _local_7 = (_local_7 + _local_8.repeats);
                    _SafeStr_748.pop();
                };
            };
            var _local_9:AnimationFrameData;
            if (_arg_6 == null)
            {
                _local_9 = new AnimationFrameData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _local_7);
            }
            else
            {
                _local_9 = new AnimationFrameDirectionalData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _local_7);
            };
            _SafeStr_748.push(_local_9);
            _SafeStr_1347.push((_SafeStr_748.length - 1));
            _SafeStr_3279.push(1);
        }

        public function getFrame(_arg_1:int):AnimationFrameData
        {
            if ((((_SafeStr_748.length == 0) || (_arg_1 < 0)) || (_arg_1 >= frameCount)))
            {
                return (null);
            };
            _arg_1 = _SafeStr_1347[(_arg_1 % _SafeStr_1347.length)];
            return (_SafeStr_748[_arg_1] as AnimationFrameData);
        }

        public function getFrameIndex(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= frameCount)))
            {
                return (-1);
            };
            if (_isRandom)
            {
                _arg_1 = int((Math.random() * _SafeStr_1347.length));
                if (_arg_1 == _SafeStr_1347.length)
                {
                    _arg_1--;
                };
            };
            return (_arg_1);
        }

        public function getRepeats(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= frameCount)))
            {
                return (0);
            };
            return (_SafeStr_3279[(_arg_1 % _SafeStr_3279.length)]);
        }


    }
}


package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationStateData 
    {

        private var _animationId:int = -1;
        private var _animationAfterTransitionId:int = 0;
        private var _animationOver:Boolean = false;
        private var _frameCounter:int = 0;
        private var _SafeStr_748:Array = [];
        private var _SafeStr_3286:Array = [];
        private var _SafeStr_3287:Array = [];
        private var _SafeStr_3288:int = 0;


        public function get animationOver():Boolean
        {
            return (_animationOver);
        }

        public function set animationOver(_arg_1:Boolean):void
        {
            _animationOver = _arg_1;
        }

        public function get frameCounter():int
        {
            return (_frameCounter);
        }

        public function set frameCounter(_arg_1:int):void
        {
            _frameCounter = _arg_1;
        }

        public function get animationId():int
        {
            return (_animationId);
        }

        public function set animationId(_arg_1:int):void
        {
            if (_arg_1 != _animationId)
            {
                _animationId = _arg_1;
                resetAnimationFrames(false);
            };
        }

        public function get animationAfterTransitionId():int
        {
            return (_animationAfterTransitionId);
        }

        public function set animationAfterTransitionId(_arg_1:int):void
        {
            _animationAfterTransitionId = _arg_1;
        }

        public function dispose():void
        {
            recycleFrames();
            _SafeStr_748 = null;
            _SafeStr_3286 = null;
            _SafeStr_3287 = null;
        }

        public function setLayerCount(_arg_1:int):void
        {
            _SafeStr_3288 = _arg_1;
            resetAnimationFrames();
        }

        public function resetAnimationFrames(_arg_1:Boolean=true):void
        {
            var _local_2:int;
            var _local_3:AnimationFrame;
            if (((_arg_1) || (_SafeStr_748 == null)))
            {
                recycleFrames();
                _SafeStr_748 = [];
            };
            _SafeStr_3286 = [];
            _SafeStr_3287 = [];
            _animationOver = false;
            _frameCounter = 0;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3288)
            {
                if (((_arg_1) || (_SafeStr_748.length <= _local_2)))
                {
                    _SafeStr_748[_local_2] = null;
                }
                else
                {
                    _local_3 = _SafeStr_748[_local_2];
                    if (_local_3 != null)
                    {
                        _local_3.recycle();
                        _SafeStr_748[_local_2] = AnimationFrame.allocate(_local_3.id, _local_3.x, _local_3.y, _local_3.repeats, 0, _local_3.isLastFrame);
                    };
                };
                _SafeStr_3286[_local_2] = false;
                _SafeStr_3287[_local_2] = false;
                _local_2++;
            };
        }

        private function recycleFrames():void
        {
            if (_SafeStr_748 != null)
            {
                for each (var _local_1:AnimationFrame in _SafeStr_748)
                {
                    if (_local_1 != null)
                    {
                        _local_1.recycle();
                    };
                };
            };
        }

        public function getFrame(_arg_1:int):AnimationFrame
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                return (_SafeStr_748[_arg_1]);
            };
            return (null);
        }

        public function setFrame(_arg_1:int, _arg_2:AnimationFrame):void
        {
            var _local_3:AnimationFrame;
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                _local_3 = _SafeStr_748[_arg_1];
                if (_local_3 != null)
                {
                    _local_3.recycle();
                };
                _SafeStr_748[_arg_1] = _arg_2;
            };
        }

        public function getAnimationPlayed(_arg_1:int):Boolean
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                return (_SafeStr_3287[_arg_1]);
            };
            return (true);
        }

        public function setAnimationPlayed(_arg_1:int, _arg_2:Boolean):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                _SafeStr_3287[_arg_1] = _arg_2;
            };
        }

        public function getLastFramePlayed(_arg_1:int):Boolean
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                return (_SafeStr_3286[_arg_1]);
            };
            return (true);
        }

        public function setLastFramePlayed(_arg_1:int, _arg_2:Boolean):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_3288)))
            {
                _SafeStr_3286[_arg_1] = _arg_2;
            };
        }


    }
}


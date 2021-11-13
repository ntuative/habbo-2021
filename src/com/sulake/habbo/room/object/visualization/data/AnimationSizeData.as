package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils._SafeStr_93;

    public class AnimationSizeData extends SizeData
    {

        private var _SafeStr_3284:Map = null;
        private var _SafeStr_3285:Array = [];

        public function AnimationSizeData(_arg_1:int, _arg_2:int)
        {
            super(_arg_1, _arg_2);
            _SafeStr_3284 = new Map();
        }

        override public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationData;
            super.dispose();
            if (_SafeStr_3284 != null)
            {
                _local_1 = 0;
                while (_local_1 < _SafeStr_3284.length)
                {
                    _local_2 = (_SafeStr_3284.getWithIndex(_local_1) as AnimationData);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _SafeStr_3284.dispose();
                _SafeStr_3284 = null;
            };
        }

        public function defineAnimations(_arg_1:XML):Boolean
        {
            var _local_6:int;
            var _local_10:XML;
            var _local_14:int;
            var _local_13:Boolean;
            var _local_5:String;
            var _local_3:int;
            var _local_12:int;
            var _local_2:AnimationData;
            var _local_8:Array;
            var _local_11:Array;
            var _local_4:int;
            if (_arg_1 == null)
            {
                return (true);
            };
            var _local_7:Array = ["id"];
            var _local_9:XMLList = _arg_1.animation;
            _local_6 = 0;
            while (_local_6 < _local_9.length())
            {
                _local_10 = _local_9[_local_6];
                if (!_SafeStr_93.checkRequiredAttributes(_local_10, _local_7))
                {
                    return (false);
                };
                _local_14 = int(_local_10.@id);
                _local_13 = false;
                _local_5 = _local_10.@transitionTo;
                if (_local_5.length > 0)
                {
                    _local_3 = int(_local_5);
                    _local_14 = AnimationData.getTransitionToAnimationId(_local_3);
                    _local_13 = true;
                };
                _local_5 = _local_10.@transitionFrom;
                if (_local_5.length > 0)
                {
                    _local_12 = int(_local_5);
                    _local_14 = AnimationData.getTransitionFromAnimationId(_local_12);
                    _local_13 = true;
                };
                _local_2 = createAnimationData();
                if (!_local_2.initialize(_local_10))
                {
                    _local_2.dispose();
                    return (false);
                };
                _local_5 = _local_10.@immediateChangeFrom;
                if (_local_5.length > 0)
                {
                    _local_8 = _local_5.split(",");
                    _local_11 = [];
                    for each (var _local_15:String in _local_8)
                    {
                        _local_4 = int(_local_15);
                        if (_local_11.indexOf(_local_4) < 0)
                        {
                            _local_11.push(_local_4);
                        };
                    };
                    _local_2.setImmediateChanges(_local_11);
                };
                _SafeStr_3284.add(_local_14, _local_2);
                if (!_local_13)
                {
                    _SafeStr_3285.push(_local_14);
                };
                _local_6++;
            };
            return (true);
        }

        protected function createAnimationData():AnimationData
        {
            return (new AnimationData());
        }

        public function hasAnimation(_arg_1:int):Boolean
        {
            if (_SafeStr_3284.getValue(_arg_1) != null)
            {
                return (true);
            };
            return (false);
        }

        public function getAnimationCount():int
        {
            return (_SafeStr_3285.length);
        }

        public function getAnimationId(_arg_1:int):int
        {
            var _local_2:int = getAnimationCount();
            if (((_arg_1 >= 0) && (_local_2 > 0)))
            {
                return (_SafeStr_3285[(_arg_1 % _local_2)]);
            };
            return (0);
        }

        public function isImmediateChange(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:AnimationData = (_SafeStr_3284.getValue(_arg_1) as AnimationData);
            if (_local_3 != null)
            {
                return (_local_3.isImmediateChange(_arg_2));
            };
            return (false);
        }

        public function getStartFrame(_arg_1:int, _arg_2:int):int
        {
            var _local_3:AnimationData = (_SafeStr_3284.getValue(_arg_1) as AnimationData);
            if (_local_3 != null)
            {
                return (_local_3.getStartFrame(_arg_2));
            };
            return (0);
        }

        public function getFrame(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):AnimationFrame
        {
            var _local_6:AnimationFrame;
            var _local_5:AnimationData = (_SafeStr_3284.getValue(_arg_1) as AnimationData);
            if (_local_5 != null)
            {
                _local_6 = _local_5.getFrame(_arg_2, _arg_3, _arg_4);
                return (_local_6);
            };
            return (null);
        }

        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):AnimationFrame
        {
            var _local_8:AnimationFrame;
            var _local_7:AnimationData = (_SafeStr_3284.getValue(_arg_1) as AnimationData);
            if (_local_7 != null)
            {
                _local_8 = _local_7.getFrameFromSequence(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
                return (_local_8);
            };
            return (null);
        }


    }
}
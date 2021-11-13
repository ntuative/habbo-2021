package com.sulake.habbo.room.object.visualization.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils._SafeStr_93;

    public class AnimationData
    {

        public static const DEFAULT_FRAME_NUMBER:int = 0;
        private static const TRANSITION_TO_ANIMATION_OFFSET:int = 1000000;
        private static const TRANSITION_FROM_ANIMATION_OFFSET:int = 2000000;

        private var _layers:Map = null;
        private var _SafeStr_2294:int = -1;
        private var _SafeStr_3273:Boolean = false;
        private var _SafeStr_3274:Array = null;

        public function AnimationData()
        {
            _layers = new Map();
        }

        public static function getTransitionToAnimationId(_arg_1:int):int
        {
            return (1000000 + _arg_1);
        }

        public static function getTransitionFromAnimationId(_arg_1:int):int
        {
            return (2000000 + _arg_1);
        }

        public static function isTransitionToAnimation(_arg_1:int):Boolean
        {
            return ((_arg_1 >= 1000000) && (_arg_1 < 2000000));
        }

        public static function isTransitionFromAnimation(_arg_1:int):Boolean
        {
            return (_arg_1 >= 2000000);
        }


        public function dispose():void
        {
            var _local_1:int;
            var _local_2:AnimationLayerData;
            if (_layers != null)
            {
                _local_1 = 0;
                while (_local_1 < _layers.length)
                {
                    _local_2 = (_layers.getWithIndex(_local_1) as AnimationLayerData);
                    if (_local_2 != null)
                    {
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                _layers.dispose();
                _layers = null;
            };
            _SafeStr_3274 = null;
        }

        public function setImmediateChanges(_arg_1:Array):void
        {
            _SafeStr_3274 = _arg_1;
        }

        public function isImmediateChange(_arg_1:int):Boolean
        {
            if (((!(_SafeStr_3274 == null)) && (_SafeStr_3274.indexOf(_arg_1) >= 0)))
            {
                return (true);
            };
            return (false);
        }

        public function getStartFrame(_arg_1:int):int
        {
            if (!_SafeStr_3273)
            {
                return (0);
            };
            return (Math.random() * _SafeStr_2294);
        }

        public function initialize(_arg_1:XML):Boolean
        {
            var _local_8:int;
            var _local_11:XML;
            var _local_9:int;
            var _local_5:int;
            var _local_2:int;
            var _local_3:Boolean;
            var _local_6:String;
            var _local_4:String;
            _SafeStr_3273 = false;
            if (int(_arg_1.@randomStart) != 0)
            {
                _SafeStr_3273 = true;
            };
            var _local_10:Array = ["id"];
            var _local_7:XMLList = _arg_1.animationLayer;
            _local_8 = 0;
            while (_local_8 < _local_7.length())
            {
                _local_11 = _local_7[_local_8];
                if (!_SafeStr_93.checkRequiredAttributes(_local_11, _local_10))
                {
                    return (false);
                };
                _local_9 = int(_local_11.@id);
                _local_5 = 1;
                _local_2 = 1;
                _local_3 = false;
                _local_6 = _local_11.@loopCount;
                if (_local_6.length > 0)
                {
                    _local_5 = int(_local_6);
                };
                _local_4 = _local_11.@frameRepeat;
                if (_local_4.length > 0)
                {
                    _local_2 = int(_local_4);
                };
                _local_3 = (!(int(_local_11.@random) == 0));
                if (!addLayer(_local_9, _local_5, _local_2, _local_3, _local_11))
                {
                    return (false);
                };
                _local_8++;
            };
            return (true);
        }

        private function addLayer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:XML):Boolean
        {
            var _local_9:int;
            var _local_11:XML;
            var _local_8:int;
            var _local_6:Boolean;
            var _local_16:String;
            var _local_14:AnimationFrameSequenceData;
            var _local_12:XMLList;
            var _local_10:int;
            var _local_23:XML;
            var _local_7:int;
            var _local_19:int;
            var _local_20:int;
            var _local_21:int;
            var _local_24:int;
            var _local_17:DirectionalOffsetData;
            var _local_18:AnimationLayerData = new AnimationLayerData(_arg_2, _arg_3, _arg_4);
            var _local_15:Array = ["id"];
            var _local_22:XMLList = _arg_5.frameSequence;
            _local_9 = 0;
            while (_local_9 < _local_22.length())
            {
                _local_11 = _local_22[_local_9];
                _local_8 = 1;
                _local_6 = false;
                _local_16 = _local_11.@loopCount;
                if (_local_16.length > 0)
                {
                    _local_8 = int(_local_16);
                };
                if (int(_local_11.@random) != 0)
                {
                    _local_6 = true;
                };
                _local_14 = _local_18.addFrameSequence(_local_8, _local_6);
                _local_12 = _local_11.frame;
                _local_10 = 0;
                while (_local_10 < _local_12.length())
                {
                    _local_23 = _local_12[_local_10];
                    if (!_SafeStr_93.checkRequiredAttributes(_local_23, _local_15))
                    {
                        _local_18.dispose();
                        return (false);
                    };
                    _local_7 = int(_local_23.@id);
                    _local_19 = int(_local_23.@x);
                    _local_20 = int(_local_23.@y);
                    _local_21 = int(_local_23.@randomX);
                    _local_24 = int(_local_23.@randomY);
                    _local_17 = readDirectionalOffsets(_local_23);
                    _local_14.addFrame(_local_7, _local_19, _local_20, _local_21, _local_24, _local_17);
                    _local_10++;
                };
                _local_14.initialize();
                _local_9++;
            };
            _local_18.calculateLength();
            _layers.add(_arg_1, _local_18);
            var _local_13:int = _local_18.frameCount;
            if (_local_13 > _SafeStr_2294)
            {
                _SafeStr_2294 = _local_13;
            };
            return (true);
        }

        private function readDirectionalOffsets(_arg_1:XML):DirectionalOffsetData
        {
            var _local_7:Array;
            var _local_5:XML;
            var _local_3:XMLList;
            var _local_9:int;
            var _local_4:XML;
            var _local_11:int;
            var _local_8:int;
            var _local_10:int;
            var _local_2:DirectionalOffsetData;
            var _local_6:XMLList = _arg_1.offsets;
            if (_local_6.length() > 0)
            {
                _local_7 = ["direction"];
                _local_5 = _local_6[0];
                _local_3 = _local_5.offset;
                _local_9 = 0;
                while (_local_9 < _local_3.length())
                {
                    _local_4 = _local_3[_local_9];
                    if (_SafeStr_93.checkRequiredAttributes(_local_4, _local_7))
                    {
                        _local_11 = int(_local_4.@direction);
                        _local_8 = int(_local_4.@x);
                        _local_10 = int(_local_4.@y);
                        if (_local_2 == null)
                        {
                            _local_2 = new DirectionalOffsetData();
                        };
                        _local_2.setOffset(_local_11, _local_8, _local_10);
                    };
                    _local_9++;
                };
            };
            return (_local_2);
        }

        public function getFrame(_arg_1:int, _arg_2:int, _arg_3:int):AnimationFrame
        {
            var _local_4:AnimationLayerData = (_layers.getValue(_arg_2) as AnimationLayerData);
            if (_local_4 != null)
            {
                return (_local_4.getFrame(_arg_1, _arg_3));
            };
            return (null);
        }

        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):AnimationFrame
        {
            var _local_6:AnimationLayerData = (_layers.getValue(_arg_2) as AnimationLayerData);
            if (_local_6 != null)
            {
                return (_local_6.getFrameFromSequence(_arg_1, _arg_3, _arg_4, _arg_5));
            };
            return (null);
        }


    }
}
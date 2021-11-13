package com.sulake.habbo.avatar.structure.animation
{
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import com.sulake.core.utils.Map;

    public class AnimationAction 
    {

        public static const DEFAULT_OFFSET:Point = new Point(0, 0);

        private var _id:String;
        private var _parts:Dictionary;
        private var _SafeStr_1346:Map = new Map();
        private var _frameCount:int;
        private var _SafeStr_1347:Array;

        public function AnimationAction(_arg_1:XML)
        {
            super();
            var _local_10:AnimationActionPart = null;
            var _local_5:int;
            var _local_12:Map = null;
            var _local_6:int;
            var _local_4:Map = null;
            var _local_11:String = null;
            var _local_13:int;
            var _local_14:int;
            var _local_3:int;
            _id = String(_arg_1.@id);
            _parts = new Dictionary();
            for each (var _local_8:XML in _arg_1.part)
            {
                _local_10 = new AnimationActionPart(_local_8);
                _parts[String(_local_8.@["set-type"])] = _local_10;
                _frameCount = Math.max(_frameCount, _local_10.frames.length);
            };
            _SafeStr_1347 = [];
            for each (var _local_2:XML in _arg_1.offsets.frame)
            {
                _local_5 = parseInt(_local_2.@id);
                _frameCount = Math.max(_frameCount, _local_5);
                _local_12 = new Map();
                _SafeStr_1346[_local_5] = _local_12;
                for each (var _local_9:XML in _local_2.directions.direction)
                {
                    _local_6 = parseInt(_local_9.@id);
                    _local_4 = new Map();
                    _local_12[_local_6] = _local_4;
                    for each (var _local_7:XML in _local_9.bodypart)
                    {
                        _local_11 = String(_local_7.@id);
                        _local_13 = ((_local_7.hasOwnProperty("@dx")) ? parseInt(_local_7.@dx) : 0);
                        _local_14 = ((_local_7.hasOwnProperty("@dy")) ? parseInt(_local_7.@dy) : 0);
                        _local_4[_local_11] = new Point(_local_13, _local_14);
                    };
                };
                _SafeStr_1347.push(_local_5);
                _local_3 = parseInt(_local_2.@repeats);
                if (_local_3 > 1)
                {
                    while (--_local_3 > 0)
                    {
                        _SafeStr_1347.push(_local_5);
                    };
                };
            };
        }

        public function getPart(_arg_1:String):AnimationActionPart
        {
            return (_parts[_arg_1] as AnimationActionPart);
        }

        public function get id():String
        {
            return (_id);
        }

        public function get parts():Dictionary
        {
            return (_parts);
        }

        public function get frameCount():int
        {
            return (_frameCount);
        }

        public function getFrameBodyPartOffset(_arg_1:int, _arg_2:int, _arg_3:String):Point
        {
            var _local_8:Point;
            var _local_6:Map;
            var _local_7:int = (_arg_2 % _SafeStr_1347.length);
            var _local_4:int = _SafeStr_1347[_local_7];
            var _local_5:Map = _SafeStr_1346[_local_4];
            if (_local_5)
            {
                _local_6 = _local_5[_arg_1];
                if (_local_6)
                {
                    _local_8 = _local_6[_arg_3];
                };
            };
            return ((_local_8 != null) ? _local_8 : DEFAULT_OFFSET);
        }


    }
}


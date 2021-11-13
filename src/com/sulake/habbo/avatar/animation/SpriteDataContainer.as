package com.sulake.habbo.avatar.animation
{
    public class SpriteDataContainer implements ISpriteDataContainer
    {

        private var _animation:IAnimation;
        private var _id:String;
        private var _ink:int;
        private var _member:String;
        private var _hasDirections:Boolean;
        private var _hasStaticY:Boolean;
        private var _SafeStr_1259:Array;
        private var _SafeStr_1260:Array;
        private var _SafeStr_1261:Array;

        public function SpriteDataContainer(_arg_1:IAnimation, _arg_2:XML)
        {
            var _local_4:int;
            super();
            _animation = _arg_1;
            _id = String(_arg_2.@id);
            _ink = parseInt(_arg_2.@ink);
            _member = String(_arg_2.@member);
            _hasStaticY = !!parseInt(_arg_2.@staticY);
            _hasDirections = !!parseInt(_arg_2.@directions);
            _SafeStr_1259 = [];
            _SafeStr_1260 = [];
            _SafeStr_1261 = [];
            for each (var _local_3:XML in _arg_2.direction)
            {
                _local_4 = parseInt(_local_3.@id);
                _SafeStr_1259[_local_4] = parseInt(_local_3.@dx);
                _SafeStr_1260[_local_4] = parseInt(_local_3.@dy);
                _SafeStr_1261[_local_4] = parseInt(_local_3.@dz);
            };
        }

        public function getDirectionOffsetX(_arg_1:int):int
        {
            if (_arg_1 < _SafeStr_1259.length)
            {
                return (_SafeStr_1259[_arg_1]);
            };
            return (0);
        }

        public function getDirectionOffsetY(_arg_1:int):int
        {
            if (_arg_1 < _SafeStr_1260.length)
            {
                return (_SafeStr_1260[_arg_1]);
            };
            return (0);
        }

        public function getDirectionOffsetZ(_arg_1:int):int
        {
            if (_arg_1 < _SafeStr_1261.length)
            {
                return (_SafeStr_1261[_arg_1]);
            };
            return (0);
        }

        public function get animation():IAnimation
        {
            return (_animation);
        }

        public function get id():String
        {
            return (_id);
        }

        public function get ink():int
        {
            return (_ink);
        }

        public function get member():String
        {
            return (_member);
        }

        public function get hasDirections():Boolean
        {
            return (_hasDirections);
        }

        public function get hasStaticY():Boolean
        {
            return (_hasStaticY);
        }


    }
}
package com.sulake.habbo.avatar.structure.animation
{
    public class AnimationActionPart 
    {

        private var _frames:Array;

        public function AnimationActionPart(_arg_1:XML)
        {
            var _local_2:int;
            super();
            _frames = [];
            for each (var _local_3:XML in _arg_1.frame)
            {
                _frames.push(new AnimationFrame(_local_3));
                _local_2 = parseInt(_local_3.@repeats);
                if (_local_2 > 1)
                {
                    while (--_local_2 > 0)
                    {
                        _frames.push(_frames[(_frames.length - 1)]);
                    };
                };
            };
        }

        public function get frames():Array
        {
            return (_frames);
        }


    }
}
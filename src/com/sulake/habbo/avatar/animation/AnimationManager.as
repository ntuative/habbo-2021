package com.sulake.habbo.avatar.animation
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarStructure;

    public class AnimationManager implements IAnimationManager 
    {

        private var _animations:Dictionary;

        public function AnimationManager()
        {
            _animations = new Dictionary();
        }

        public function registerAnimation(_arg_1:AvatarStructure, _arg_2:XML):Boolean
        {
            var _local_3:String = String(_arg_2.@name);
            _animations[_local_3] = new Animation(_arg_1, _arg_2);
            return (true);
        }

        public function getAnimation(_arg_1:String):IAnimation
        {
            return (_animations[_arg_1]);
        }

        public function getLayerData(_arg_1:String, _arg_2:int, _arg_3:String):IAnimationLayerData
        {
            var _local_4:Animation = (_animations[_arg_1] as Animation);
            if (_local_4 != null)
            {
                return (_local_4.getLayerData(_arg_2, _arg_3));
            };
            return (null);
        }

        public function get animations():Dictionary
        {
            return (_animations);
        }


    }
}
package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureSoundBlockVisualization extends AnimatedFurnitureVisualization 
    {

        private var _frameIncrease:int = 1;
        private var _SafeStr_3366:Number = 0;


        override protected function get frameIncrease():int
        {
            return (_frameIncrease);
        }

        override protected function updateAnimations(_arg_1:Number):int
        {
            _SafeStr_3366 = (_SafeStr_3366 + object.getModel().getNumber("furniture_soundblock_relative_animation_speed"));
            _frameIncrease = _SafeStr_3366;
            _SafeStr_3366 = (_SafeStr_3366 - _frameIncrease);
            return (super.updateAnimations(_arg_1));
        }


    }
}


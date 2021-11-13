package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureQueueTileVisualization extends AnimatedFurnitureVisualization 
    {

        private static const _SafeStr_3299:int = 3;
        private static const _SafeStr_3356:int = 2;
        private static const ANIMATION_ID_NORMAL:int = 1;
        private static const _SafeStr_3357:int = 15;

        private var _SafeStr_3300:Array = [];
        private var _SafeStr_3358:int;


        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == 2)
            {
                _SafeStr_3300 = [];
                _SafeStr_3300.push(1);
                _SafeStr_3358 = 15;
            };
            super.setAnimation(_arg_1);
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            if (_SafeStr_3358 > 0)
            {
                _SafeStr_3358--;
            };
            if (_SafeStr_3358 == 0)
            {
                if (_SafeStr_3300.length > 0)
                {
                    super.setAnimation(_SafeStr_3300.shift());
                };
            };
            return (super.updateAnimation(_arg_1));
        }

        override protected function usesAnimationResetting():Boolean
        {
            return (true);
        }


    }
}


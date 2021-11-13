package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureBottleVisualization extends AnimatedFurnitureVisualization 
    {

        private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
        private static const ANIMATION_ID_OFFSET_SLOW2:int = 9;
        private static const _SafeStr_3299:int = -1;

        private var _SafeStr_3300:Array = [];
        private var _SafeStr_801:Boolean = false;


        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == -1)
            {
                if (!_SafeStr_801)
                {
                    _SafeStr_801 = true;
                    _SafeStr_3300 = [];
                    _SafeStr_3300.push(-1);
                    return;
                };
            };
            if (((_arg_1 >= 0) && (_arg_1 <= 7)))
            {
                if (_SafeStr_801)
                {
                    _SafeStr_801 = false;
                    _SafeStr_3300 = [];
                    _SafeStr_3300.push(20);
                    _SafeStr_3300.push((9 + _arg_1));
                    _SafeStr_3300.push(_arg_1);
                    return;
                };
                super.setAnimation(_arg_1);
            };
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            if (super.getLastFramePlayed(0))
            {
                if (_SafeStr_3300.length > 0)
                {
                    super.setAnimation(_SafeStr_3300.shift());
                };
            };
            return (super.updateAnimation(_arg_1));
        }


    }
}


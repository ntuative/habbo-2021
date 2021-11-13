package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureHabboWheelVisualization extends AnimatedFurnitureVisualization 
    {

        private static const ANIMATION_ID_OFFSET_SLOW1:int = 10;
        private static const ANIMATION_ID_OFFSET_SLOW2:int = 20;
        private static const _SafeStr_3313:int = 31;
        private static const _SafeStr_3299:int = 32;

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
                    _SafeStr_3300.push(31);
                    _SafeStr_3300.push(32);
                    return;
                };
            };
            if (((_arg_1 > 0) && (_arg_1 <= 10)))
            {
                if (_SafeStr_801)
                {
                    _SafeStr_801 = false;
                    _SafeStr_3300 = [];
                    _SafeStr_3300.push((10 + _arg_1));
                    _SafeStr_3300.push((20 + _arg_1));
                    _SafeStr_3300.push(_arg_1);
                    return;
                };
                super.setAnimation(_arg_1);
            };
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            if ((((super.getLastFramePlayed(1)) && (super.getLastFramePlayed(2))) && (super.getLastFramePlayed(3))))
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


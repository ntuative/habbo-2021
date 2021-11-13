package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureValRandomizerVisualization extends AnimatedFurnitureVisualization 
    {

        private static const ANIMATION_ID_OFFSET_SLOW1:int = 20;
        private static const ANIMATION_ID_OFFSET_SLOW2:int = 10;
        private static const _SafeStr_3313:int = 31;
        private static const _SafeStr_3299:int = 32;
        private static const _SafeStr_3367:int = 30;

        private var _SafeStr_3300:Array = [];
        private var _SafeStr_801:Boolean = false;

        public function FurnitureValRandomizerVisualization()
        {
            super.setAnimation(30);
        }

        override protected function setAnimation(_arg_1:int):void
        {
            if (_arg_1 == 0)
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
                    if (direction == 2)
                    {
                        _SafeStr_3300.push(((20 + 5) - _arg_1));
                        _SafeStr_3300.push(((10 + 5) - _arg_1));
                    }
                    else
                    {
                        _SafeStr_3300.push((20 + _arg_1));
                        _SafeStr_3300.push((10 + _arg_1));
                    };
                    _SafeStr_3300.push(30);
                    return;
                };
                super.setAnimation(30);
            };
        }

        override protected function updateAnimation(_arg_1:Number):int
        {
            if (super.getLastFramePlayed(11))
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


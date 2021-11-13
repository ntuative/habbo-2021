package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.EventDispatcher;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;

    public class SpiralMovingBackgroundObject extends BackgroundObject 
    {

        private var _startRadius:int;
        private var _SafeStr_2288:int;
        private var _posRadius:Number;
        private var _SafeStr_2289:Number;
        private var _speedRadius:Number;
        private var _SafeStr_2290:Number;
        private var _SafeStr_2291:Number;
        private var _SafeStr_2292:Number;

        public function SpiralMovingBackgroundObject(_arg_1:int, _arg_2:IWindowContainer, _arg_3:EventDispatcher, _arg_4:HabboLandingView, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            var _local_7:Array = _arg_5.split(";");
            var _local_6:String = _local_7[0];
            _startRadius = _local_7[2];
            _SafeStr_2288 = _local_7[3];
            _speedRadius = _local_7[4];
            _SafeStr_2290 = _local_7[5];
            _SafeStr_2291 = _local_7[6];
            _SafeStr_2292 = _local_7[7];
            _posRadius = _startRadius;
            _SafeStr_2289 = _SafeStr_2288;
            sprite.assetUri = (("${image.library.url}reception/" + _local_6) + ".png");
        }

        override public function update(_arg_1:uint):void
        {
            super.update(_arg_1);
            var _local_2:Number = (_startRadius / _posRadius);
            var _local_3:Number = (1 + ((_startRadius / _posRadius) / 8));
            _posRadius = (_posRadius + (_arg_1 * _speedRadius));
            _SafeStr_2289 = (_SafeStr_2289 + ((_arg_1 * _SafeStr_2290) * _local_2));
            if (sprite.bitmapData)
            {
                if (_posRadius <= 0)
                {
                    _posRadius = _startRadius;
                    sprite.width = sprite.bitmapData.width;
                    sprite.height = sprite.bitmapData.height;
                    events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET", id));
                };
            };
            if (_posRadius > _startRadius)
            {
                _posRadius = 0;
                sprite.width = 0;
                sprite.height = 0;
                events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET", id));
            };
            if (_SafeStr_2289 < 0)
            {
                _SafeStr_2289 = (3.14159265358979 * 2);
            };
            if (_SafeStr_2289 > (3.14159265358979 * 2))
            {
                _SafeStr_2289 = 0;
            };
            sprite.x = (_SafeStr_2291 + (Math.sin(_SafeStr_2289) * _posRadius));
            sprite.y = (_SafeStr_2292 + (Math.cos(_SafeStr_2289) * _posRadius));
            if (sprite.bitmapData)
            {
                sprite.pivotPoint = 4;
                sprite.stretchedX = true;
                sprite.stretchedY = true;
                sprite.width = (sprite.bitmapData.width / _local_3);
                sprite.height = (sprite.bitmapData.height / _local_3);
            };
        }


    }
}


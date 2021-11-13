package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.EventDispatcher;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.utils._SafeStr_25;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;

    public class RandomWalkMovingBackgroundObject extends BackgroundObject 
    {

        private var _SafeStr_1143:int;
        private var _SafeStr_1144:int;
        private var _SafeStr_2280:Number;
        private var _SafeStr_2281:Number;
        private var _SafeStr_2278:Number;
        private var _SafeStr_2279:Number;
        private var _SafeStr_2282:Number;
        private var _SafeStr_1163:uint = 0;
        private var _SafeStr_2276:Number;
        private var _SafeStr_2277:Number;
        private var _SafeStr_2283:Number = 0;
        private var _SafeStr_2284:Number = 0;
        private var _SafeStr_2285:Number = 0;
        private var _SafeStr_2286:Number = 0;
        private var _SafeStr_2287:uint;

        public function RandomWalkMovingBackgroundObject(_arg_1:int, _arg_2:IWindowContainer, _arg_3:EventDispatcher, _arg_4:HabboLandingView, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
            var _local_7:Array = _arg_5.split(";");
            var _local_6:String = _local_7[0];
            _SafeStr_1143 = _local_7[2];
            _SafeStr_1144 = _local_7[3];
            _SafeStr_2278 = _local_7[4];
            _SafeStr_2279 = _local_7[5];
            _SafeStr_2280 = _local_7[6];
            _SafeStr_2281 = _local_7[7];
            _SafeStr_2282 = _local_7[8];
            _SafeStr_2276 = _SafeStr_1143;
            _SafeStr_2277 = _SafeStr_1144;
            sprite.assetUri = (("${image.library.url}" + _local_6) + ".png");
        }

        override public function update(_arg_1:uint):void
        {
            super.update(_arg_1);
            if (!sprite)
            {
                return;
            };
            _SafeStr_1163 = (_SafeStr_1163 + _arg_1);
            if ((_SafeStr_1163 - _SafeStr_2287) > _SafeStr_2282)
            {
                _SafeStr_2285 = _SafeStr_2283;
                _SafeStr_2286 = _SafeStr_2284;
                _SafeStr_2283 = (((Math.random() * 2) - 1) * _SafeStr_2280);
                _SafeStr_2284 = (((Math.random() * 2) - 1) * _SafeStr_2281);
                _SafeStr_2287 = _SafeStr_1163;
            };
            var _local_4:int = window.width;
            var _local_2:int = window.height;
            var _local_3:Number = ((_SafeStr_1163 - _SafeStr_2287) / _SafeStr_2282);
            _SafeStr_2276 = (_SafeStr_2276 + ((_arg_1 / 1000) * (_SafeStr_2278 + _SafeStr_25.lerp(_local_3, _SafeStr_2285, _SafeStr_2283))));
            _SafeStr_2277 = (_SafeStr_2277 + ((_arg_1 / 1000) * (_SafeStr_2279 + _SafeStr_25.lerp(_local_3, _SafeStr_2286, _SafeStr_2284))));
            sprite.x = _SafeStr_2276;
            sprite.y = _SafeStr_2277;
            if ((((((_SafeStr_2278 > 0) && (sprite.x > _local_4)) || ((_SafeStr_2278 < 0) && ((sprite.x + sprite.width) < 0))) || ((_SafeStr_2279 > 0) && (sprite.y > _local_2))) || ((_SafeStr_2279 < 0) && ((sprite.y + sprite.height) < 0))))
            {
                _SafeStr_2276 = _SafeStr_1143;
                _SafeStr_2277 = _SafeStr_1144;
                events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET", id));
            };
        }


    }
}


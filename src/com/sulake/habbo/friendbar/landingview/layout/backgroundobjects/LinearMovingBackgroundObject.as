package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.EventDispatcher;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;

    public class LinearMovingBackgroundObject extends BackgroundObject 
    {

        private var _SafeStr_1143:int;
        private var _SafeStr_1144:int;
        private var _SafeStr_2276:Number;
        private var _SafeStr_2277:Number;
        private var _SafeStr_2278:Number;
        private var _SafeStr_2279:Number;

        public function LinearMovingBackgroundObject(_arg_1:int, _arg_2:IWindowContainer, _arg_3:EventDispatcher, _arg_4:HabboLandingView, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            var _local_7:Array = _arg_5.split(";");
            var _local_6:String = _local_7[0];
            _SafeStr_1143 = _local_7[2];
            _SafeStr_1144 = _local_7[3];
            _SafeStr_2278 = _local_7[4];
            _SafeStr_2279 = _local_7[5];
            _SafeStr_2276 = _SafeStr_1143;
            _SafeStr_2277 = _SafeStr_1144;
            sprite.assetUri = (("${image.library.url}reception/" + _local_6) + ".png");
        }

        override public function update(_arg_1:uint):void
        {
            super.update(_arg_1);
            if (!sprite)
            {
                return;
            };
            var _local_3:int = window.width;
            var _local_2:int = window.height;
            _SafeStr_2276 = (_SafeStr_2276 + (_arg_1 * _SafeStr_2278));
            _SafeStr_2277 = (_SafeStr_2277 + (_arg_1 * _SafeStr_2279));
            sprite.x = _SafeStr_2276;
            sprite.y = (_SafeStr_2277 + window.desktop.height);
            if ((((((_SafeStr_2278 > 0) && (sprite.x > _local_3)) || ((_SafeStr_2278 < 0) && ((sprite.x + sprite.width) < 0))) || ((_SafeStr_2279 > 0) && (sprite.y > _local_2))) || ((_SafeStr_2279 < 0) && ((sprite.y + sprite.height) < 0))))
            {
                _SafeStr_2276 = _SafeStr_1143;
                _SafeStr_2277 = _SafeStr_1144;
                events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET", id));
            };
        }


    }
}


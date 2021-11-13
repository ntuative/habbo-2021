package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.EventDispatcher;
    import com.sulake.habbo.friendbar.landingview.HabboLandingView;
    import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;

    public class StaticAnimatedBackgroundObject extends BackgroundObject 
    {

        private var _SafeStr_2293:uint = 0;
        private var _imageBaseUri:String;
        private var _SafeStr_2294:int;
        private var _fps:int;
        private var _SafeStr_2276:int;
        private var _SafeStr_2277:int;
        private var _SafeStr_2295:Array;
        private var _SafeStr_2296:uint = 0;

        public function StaticAnimatedBackgroundObject(_arg_1:int, _arg_2:IWindowContainer, _arg_3:EventDispatcher, _arg_4:HabboLandingView, _arg_5:String)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            var _local_6:Array = _arg_5.split(";");
            _imageBaseUri = ("${image.library.url}reception/" + _local_6[0]);
            _SafeStr_2294 = _local_6[2];
            _fps = _local_6[3];
            _SafeStr_2276 = _local_6[4];
            _SafeStr_2277 = _local_6[5];
            _SafeStr_2295 = _local_6[6].split(",");
            _arg_3.addEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET", onPathResetEvent);
            sprite.x = _SafeStr_2276;
            sprite.y = _SafeStr_2277;
        }

        override public function dispose():void
        {
            events.removeEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET", onPathResetEvent);
            super.dispose();
        }

        override public function update(_arg_1:uint):void
        {
            super.update(_arg_1);
            var _local_4:int = int((1000 / _fps));
            var _local_2:uint = (_SafeStr_2293 - _SafeStr_2296);
            var _local_3:int = (_SafeStr_2294 - 1);
            if (_SafeStr_2295.length > 0)
            {
                if (_local_2 < (_SafeStr_2294 * _local_4))
                {
                    _local_3 = int((_local_2 / _local_4));
                };
            }
            else
            {
                _local_3 = (_SafeStr_2293 % _local_4);
            };
            sprite.assetUri = ((_imageBaseUri + (_local_3 + 1)) + ".png");
            _SafeStr_2293 = (_SafeStr_2293 + _arg_1);
        }

        private function onPathResetEvent(_arg_1:PathResetEvent):void
        {
            if (_SafeStr_2295.indexOf(_arg_1.objectId.toString()) != -1)
            {
                _SafeStr_2296 = _SafeStr_2293;
            };
        }


    }
}


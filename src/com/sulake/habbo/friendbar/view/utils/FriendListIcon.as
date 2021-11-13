package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.TimerEvent;

    public class FriendListIcon extends Icon 
    {

        private static const _SafeStr_2430:int = 200;
        private static const _SafeStr_2431:int = 500;

        private var _assets:IAssetLibrary;

        public function FriendListIcon(_arg_1:IAssetLibrary, _arg_2:IBitmapWrapperWindow)
        {
            _assets = _arg_1;
            alignment = (0x01 | 0x08);
            image = (_arg_1.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            canvas = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                _assets = null;
                super.dispose();
            };
        }

        override public function notify(_arg_1:Boolean):void
        {
            super.notify(_arg_1);
            enable(_arg_1);
            toggleTimer(((_arg_1) || (_hover)), ((_hover) ? 200 : 500));
            if (((!(_SafeStr_2432)) && (!(_hover))))
            {
                image = (_assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            };
        }

        override public function hover(_arg_1:Boolean):void
        {
            super.hover(_arg_1);
            toggleTimer(((_arg_1) || (_SafeStr_2432)), ((_hover) ? 200 : 500));
            if (((!(_SafeStr_2432)) && (!(_hover))))
            {
                image = (_assets.getAssetByName("icon_friendlist_png") as BitmapDataAsset);
            };
        }

        override public function enable(_arg_1:Boolean):void
        {
            canvas.blend = ((disabled) ? 0.5 : 1);
        }

        override protected function onTimerEvent(_arg_1:TimerEvent):void
        {
            if (_hover)
            {
                _frame = (++_frame % 4);
                image = (_assets.getAssetByName((("icon_friendlist_hover_" + _frame) + "_png")) as BitmapDataAsset);
            }
            else
            {
                if (_SafeStr_2432)
                {
                    _frame = (++_frame % 2);
                    image = (_assets.getAssetByName((("icon_friendlist_notify_" + _frame) + "_png")) as BitmapDataAsset);
                };
            };
        }


    }
}


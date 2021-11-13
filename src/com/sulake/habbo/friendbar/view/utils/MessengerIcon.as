package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.TimerEvent;

    public class MessengerIcon extends Icon 
    {

        private static const _SafeStr_2431:int = 500;

        private var _assets:IAssetLibrary;

        public function MessengerIcon(_arg_1:IAssetLibrary, _arg_2:IBitmapWrapperWindow)
        {
            _assets = _arg_1;
            alignment = (0x01 | 0x08);
            image = (_arg_1.getAssetByName("icon_messenger_png") as BitmapDataAsset);
            canvas = _arg_2;
        }

        override public function notify(_arg_1:Boolean):void
        {
            super.notify(_arg_1);
            image = (_assets.getAssetByName(((_arg_1) ? "icon_messenger_notify_1_png" : "icon_messenger_png")) as BitmapDataAsset);
            toggleTimer(_arg_1, 500);
        }

        override public function hover(_arg_1:Boolean):void
        {
            super.hover(_arg_1);
        }

        override public function enable(_arg_1:Boolean):void
        {
            super.enable(_arg_1);
            canvas.visible = _arg_1;
        }

        override protected function onTimerEvent(_arg_1:TimerEvent):void
        {
            if (_SafeStr_2432)
            {
                _frame = ((_frame == 1) ? 0 : 1);
                image = (_assets.getAssetByName((("icon_messenger_notify_" + _frame) + "_png")) as BitmapDataAsset);
            };
        }


    }
}


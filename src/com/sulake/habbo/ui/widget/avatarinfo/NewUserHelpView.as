package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;

    public class NewUserHelpView extends AvatarContextInfoButtonView 
    {

        private var _caption:String = "";

        public function NewUserHelpView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
            _caption = _arg_1.localization.getLocalization("room.enter.infostand.caption", "");
            _SafeStr_3933 = _arg_1.configuration.getInteger("room.enter.infostand.fade.start.delay", 5000);
        }

        public static function setup(_arg_1:AvatarContextInfoButtonView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int):void
        {
            AvatarContextInfoButtonView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }


        override protected function updateWindow():void
        {
            var _local_1:XML;
            var _local_2:IWindow;
            if ((((!(_SafeStr_1324)) || (!(_SafeStr_1324.assets))) || (!(_SafeStr_1324.windowManager))))
            {
                return;
            };
            if (!_window)
            {
                _local_1 = (_SafeStr_1324.assets.getAssetByName("new_user_help").content as XML);
                _window = (_SafeStr_1324.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                if (!_window)
                {
                    return;
                };
                _local_2 = _window.findChildByName("help");
                _local_2.caption = _caption;
                _window.invalidate();
            };
            activeView = _window;
        }

        public function get widget():AvatarInfoWidget
        {
            return (_SafeStr_1324 as AvatarInfoWidget);
        }


    }
}


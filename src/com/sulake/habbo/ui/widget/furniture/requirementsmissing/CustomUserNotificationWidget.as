package com.sulake.habbo.ui.widget.furniture.requirementsmissing
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.ui.handler.CustomUserNotificationWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.inventory.IAvatarEffect;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class CustomUserNotificationWidget extends RoomWidgetBase 
    {

        public static const TYPE_VIPHOPPER:String = "viphopper";
        public static const _SafeStr_4130:String = "vipgate";
        public static const TYPE_COSTUMEHOPPER:String = "costumehopper";
        public static const TYPE_RESPECT_VOTE_FAILED_NO_STAGE:String = "respectfailedstage";
        public static const _SafeStr_4131:String = "respectfailedaudience";

        private var _window:IFrameWindow;
        private var _SafeStr_4129:CustomUserNotificationWidgetHandler;

        public function CustomUserNotificationWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_4129 = CustomUserNotificationWidgetHandler(_arg_1);
            _SafeStr_4129.widget = this;
        }

        public function open(_arg_1:String=""):void
        {
            if (!_window)
            {
                switch (_arg_1)
                {
                    case "viphopper":
                        buildWindow("viprequired_xml");
                        setVipRequiredSpecificLocalization("viphopper");
                        break;
                    case "vipgate":
                        buildWindow("viprequired_xml");
                        setVipRequiredSpecificLocalization("gate");
                        break;
                    case "costumehopper":
                        buildWindow("costumehopper_costumerequired_xml");
                        break;
                    case "respectfailedstage":
                        buildWindow("respect_giving_failed_notification_xml");
                        setText("stage");
                        setBitmapUrl("stage");
                        break;
                    case "respectfailedaudience":
                        buildWindow("respect_giving_failed_notification_xml");
                        setText("audience");
                        setBitmapUrl("audience");
                };
                _window.center();
                _window.procedure = eventProc;
            };
        }

        private function buildWindow(_arg_1:String):void
        {
            _window = IFrameWindow(windowManager.buildFromXML(XML(assets.getAssetByName(_arg_1).content)));
        }

        private function setVipRequiredSpecificLocalization(_arg_1:String):void
        {
            _window.findChildByName("title").caption = (("${" + _arg_1) + ".viprequired.title}");
            _window.findChildByName("bodytext").caption = (("${" + _arg_1) + ".viprequired.bodytext}");
        }

        private function setText(_arg_1:String):void
        {
            var _local_4:String = ("respect.giving.failed.no." + _arg_1);
            var _local_2:String = _SafeStr_4129.container.localization.getLocalization(_local_4);
            var _local_3:String = _SafeStr_4129.container.config.getProperty("respect.talent.show.min.audience");
            if (_local_3)
            {
                _local_2 = _local_2.replace("%users%", _local_3);
            };
            _window.findChildByName("body_txt").caption = _local_2;
        }

        private function setBitmapUrl(_arg_1:String):void
        {
            var _local_3:String = (("${image.library.url}notifications/habbo_talent_show_" + _arg_1) + ".png");
            var _local_2:IStaticBitmapWrapperWindow = (_window.content.getChildByName("respectFailedNotificationBitmap") as IStaticBitmapWrapperWindow);
            _local_2.assetUri = _local_3;
        }

        public function close():void
        {
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        private function eventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Array;
            var _local_5:Boolean;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "buy_vip":
                        if (((!(_SafeStr_4129 == null)) && (!(_SafeStr_4129.container == null))))
                        {
                            _SafeStr_4129.container.catalog.openClubCenter();
                        };
                        close();
                        break;
                    case "vip_benefits":
                        _SafeStr_4129.container.catalog.showVipBenefits();
                        break;
                    case "buy_costumes":
                        _local_4 = _SafeStr_4129.container.inventory.getAvatarEffects();
                        _local_5 = false;
                        for each (var _local_3:IAvatarEffect in _local_4)
                        {
                            if (_local_3.subType == 1)
                            {
                                _local_5 = true;
                                break;
                            };
                        };
                        if (_local_5)
                        {
                            _SafeStr_4129.container.avatarEditor.openEditor(0, null, null, true, null, "effects");
                            _SafeStr_4129.container.avatarEditor.loadOwnAvatarInEditor(0);
                        }
                        else
                        {
                            _SafeStr_4129.container.catalog.openCatalogPage("costumes");
                        };
                        close();
                        break;
                    case "close":
                        close();
                };
                if (_arg_2.tags.indexOf("close") != -1)
                {
                    close();
                };
            };
        }


    }
}


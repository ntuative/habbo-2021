package com.sulake.habbo.ui.widget.furniture.credit
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class CreditFurniWidget extends RoomWidgetBase
    {

        private static const _SafeStr_4079:Number = 100;
        private static const _SafeStr_4080:Number = 100;

        private var _window:IWindowContainer;
        private var _SafeStr_4081:int = -1;
        private var _SafeStr_4082:Number;

        public function CreditFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function dispose():void
        {
            hideInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.addEventListener("RWCFUE_CREDIT_FURNI_UPDATE", onObjectUpdate);
            super.registerUpdateEvents(_arg_1);
        }

        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _arg_1.removeEventListener("RWCFUE_CREDIT_FURNI_UPDATE", onObjectUpdate);
        }

        private function onObjectUpdate(_arg_1:RoomWidgetCreditFurniUpdateEvent):void
        {
            hideInterface();
            _SafeStr_4081 = _arg_1.objectId;
            _SafeStr_4082 = _arg_1.creditValue;
            showInterface();
        }

        private function showInterface():void
        {
            var _local_2:IWindow;
            if (_SafeStr_4081 == -1)
            {
                return;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            windowManager.registerLocalizationParameter("widgets.furniture.credit.redeem.value", "value", String(_SafeStr_4082));
            var _local_3:IAsset = assets.getAssetByName("credit_redeem");
            var _local_1:XmlAsset = XmlAsset(_local_3);
            if (_local_1 == null)
            {
                return;
            };
            _window = (windowManager.createWindow("creditfurniui_container", "", 4, 0, (0x020000 | 0x01), new Rectangle(100, 100, 2, 2), null, 0) as IWindowContainer);
            _window.buildFromXML(XML(_local_1.content));
            _window.background = true;
            _window.color = 0x1FFFFFF;
            _local_2 = _window.findChildByName("cancel");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_2 = _window.findChildByName("exchange");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_2 = _window.findChildByName("link");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onMouseEvent);
            };
            _local_2 = _window.findChildByTag("close");
            if (_local_2 != null)
            {
                _local_2.procedure = onWindowClose;
            };
            _window.addEventListener("WME_CLICK", onMouseEvent);
        }

        private function hideInterface():void
        {
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
            _SafeStr_4081 = -1;
            _SafeStr_4082 = 0;
        }

        private function sendRedeemMessage():void
        {
            var _local_1:RoomWidgetCreditFurniRedeemMessage;
            if (_SafeStr_4081 == -1)
            {
                return;
            };
            if (messageListener != null)
            {
                _local_1 = new RoomWidgetCreditFurniRedeemMessage("RWFCRM_REDEEM", _SafeStr_4081);
                messageListener.processWidgetMessage(_local_1);
                hideInterface();
            };
        }

        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_4:String;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3)
            {
                case "link":
                    _local_4 = localizations.getLocalization("widget.furni.info.url");
                    if (_local_4.indexOf("http") == 0)
                    {
                        HabboWebTools.navigateToURL(_local_4, "habboMain");
                    };
                    return;
                case "exchange":
                    sendRedeemMessage();
                    return;
                case "cancel":
                case "close":
                    hideInterface();
                    return;
            };
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            hideInterface();
        }


    }
}
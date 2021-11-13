package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.toolbar.IExtensionView;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.perk.CitizenshipVipOfferPromoEnabledEvent;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;

    public class CitizenshipVipQuestsPromoExtension 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _SafeStr_913:IEventDispatcher;
        private var _localization:ICoreLocalizationManager;
        private var _connection:IConnection;
        private var _SafeStr_3788:IExtensionView;
        private var _SafeStr_570:_SafeStr_124;
        private var _disposed:Boolean = false;
        private var _expanded:Boolean = true;
        private var _SafeStr_2392:int = 216;
        private var _vipQuestsCampaignName:String;
        private var _SafeStr_3787:IMessageEvent = null;

        public function CitizenshipVipQuestsPromoExtension(_arg_1:HabboToolbar, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IEventDispatcher, _arg_5:ICoreLocalizationManager, _arg_6:IConnection)
        {
            _windowManager = _arg_2;
            _assets = _arg_3;
            _SafeStr_913 = _arg_4;
            _localization = _arg_5;
            _connection = _arg_6;
            _SafeStr_3788 = _arg_1.extensionView;
            _SafeStr_3787 = new CitizenshipVipOfferPromoEnabledEvent(onCitizenshipQuestPromoEnabled);
            _connection.addMessageEvent(_SafeStr_3787);
            _vipQuestsCampaignName = _arg_1.getProperty("citizenship.vip.tutorial.quest.campaign.name");
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (((_connection) && (_SafeStr_3787)))
            {
                _connection.removeMessageEvent(_SafeStr_3787);
                _SafeStr_3787 = null;
            };
            destroyWindow();
            _localization = null;
            _assets = null;
            _SafeStr_913 = null;
            _windowManager = null;
            _connection = null;
            _SafeStr_3788 = null;
            _disposed = true;
        }

        private function createWindow():_SafeStr_124
        {
            var _local_1:_SafeStr_124;
            var _local_2:IAsset = _assets.getAssetByName("vip_quests_promo_xml");
            if (_local_2)
            {
                _local_1 = (_windowManager.buildFromXML((_local_2.content as XML), 1) as _SafeStr_124);
                if (_local_1)
                {
                    (_SafeStr_101(_local_1.findChildByName("quests_button").addEventListener("WME_CLICK", onButtonClicked)));
                    IRegionWindow(_local_1.findChildByName("minimize_region")).addEventListener("WME_CLICK", onMinMax);
                    IRegionWindow(_local_1.findChildByName("maximize_region")).addEventListener("WME_CLICK", onMinMax);
                    _SafeStr_2392 = _local_1.height;
                };
            };
            return (_local_1);
        }

        private function destroyWindow():void
        {
            if (_SafeStr_3788)
            {
                _SafeStr_3788.detachExtension("vip_quests");
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.dispose();
                _SafeStr_570 = null;
            };
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (_connection)
            {
                _connection.send(new StartCampaignMessageComposer(_vipQuestsCampaignName));
            };
            destroyWindow();
        }

        private function onMinMax(_arg_1:WindowMouseEvent):void
        {
            _expanded = (!(_expanded));
            assignState();
        }

        private function assignState():void
        {
            IItemListWindow(_SafeStr_570.findChildByName("content_itemlist")).visible = _expanded;
            IStaticBitmapWrapperWindow(_SafeStr_570.findChildByName("promo_img")).visible = _expanded;
            _SafeStr_570.height = ((_expanded) ? _SafeStr_2392 : 33);
        }

        private function onCitizenshipQuestPromoEnabled(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_570 == null)
            {
                _SafeStr_570 = createWindow();
            };
            assignState();
            _SafeStr_3788.detachExtension("club_promo");
            _SafeStr_3788.attachExtension("vip_quests", _SafeStr_570, 10);
        }


    }
}


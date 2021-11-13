package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ICoreConfiguration;

    public class ClubExtendController 
    {

        private var _config:HabboCatalog;
        private var _SafeStr_516:ClubExtendConfirmationDialog;
        private var _offer:ClubOfferExtendData;
        private var _disposed:Boolean = false;

        public function ClubExtendController(_arg_1:HabboCatalog)
        {
            _config = _arg_1;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            closeConfirmation();
            _offer = null;
            _config = null;
            _disposed = true;
        }

        public function onOffer(_arg_1:HabboClubExtendOfferMessageEvent):void
        {
            if (_disposed)
            {
                return;
            };
            var _local_2:HabboClubExtendOfferMessageParser = _arg_1.getParser();
            _offer = _local_2.offer();
            showConfirmation();
            if (_config.connection)
            {
                if (_offer.vip)
                {
                    _config.connection.send(new EventLogMessageComposer("Catalog", "dialog_show", "vip.membership.extension.purchase"));
                }
                else
                {
                    _config.connection.send(new EventLogMessageComposer("Catalog", "dialog_show", "basic.membership.extension.purchase"));
                };
            };
        }

        public function closeConfirmation():void
        {
            if (_SafeStr_516)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        public function showConfirmation():void
        {
            closeConfirmation();
            _SafeStr_516 = new ClubExtendConfirmationDialog(this, _offer);
            _SafeStr_516.showConfirmation();
        }

        public function confirmSelection():void
        {
            if ((((!(_config)) || (!(_config.connection))) || (!(_offer))))
            {
                return;
            };
            if (_config.getPurse().credits < _offer.priceCredits)
            {
                _config.showNotEnoughCreditsAlert();
                return;
            };
            if (_offer.vip)
            {
                _config.purchaseVipMembershipExtension(_offer.offerId);
            }
            else
            {
                _config.purchaseBasicMembershipExtension(_offer.offerId);
            };
            closeConfirmation();
        }

        public function get windowManager():IHabboWindowManager
        {
            if (!_config)
            {
                return (null);
            };
            return (_config.windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            if (!_config)
            {
                return (null);
            };
            return (_config.localization);
        }

        public function get assets():IAssetLibrary
        {
            if (!_config)
            {
                return (null);
            };
            return (_config.assets);
        }

        public function get config():ICoreConfiguration
        {
            return (_config);
        }


    }
}


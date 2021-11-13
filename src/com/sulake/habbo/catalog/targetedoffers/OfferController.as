package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.targetedoffers.util.MallOfferExternalInterfaceHelper;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferNotFoundEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetNextTargetedOfferComposer;
    import com.sulake.habbo.communication.messages.parser.catalog.TargetedOfferParser;
    import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
    import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.ShopTargetedOfferViewedComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SetTargetedOfferStateComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseTargetedOfferComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.purse.PurseUpdateEvent;

    public class OfferController implements IProductDataListener 
    {

        private var _offerDialog:TargetedOfferDialogView;
        private var _SafeStr_1505:MallOfferDialogView;
        private var _extension:IDisposable;
        private var _confirmation:TargetedOfferPurchaseConfirmationView;
        private var _SafeStr_1506:MallOfferExternalInterfaceHelper;
        private var _catalog:HabboCatalog;
        private var _disposed:Boolean;

        public function OfferController(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
            _catalog.connection.addMessageEvent(new TargetedOfferEvent(onTargetedOffer));
            _catalog.connection.addMessageEvent(new TargetedOfferNotFoundEvent(onTargetedOfferNotFound));
            _catalog.events.addEventListener("catalog_purse_update", onPurseUpdate);
            _catalog.sessionDataManager.addProductsReadyEventListener(this);
        }

        public function get catalog():HabboCatalog
        {
            return (_catalog);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            destroyView();
            if (_SafeStr_1506)
            {
                _SafeStr_1506.dispose();
                _SafeStr_1506 = null;
            };
        }

        public function productDataReady():void
        {
            _catalog.connection.send(new GetNextTargetedOfferComposer());
        }

        private function onTargetedOffer(_arg_1:TargetedOfferEvent):void
        {
            var _local_3:TargetedOfferParser = _arg_1.getParser();
            var _local_2:TargetedOffer = new TargetedOffer(_local_3.data);
            if (_local_2.trackingState == 4)
            {
                minimizeOffer(_local_2);
            }
            else
            {
                maximizeOffer(_local_2);
            };
        }

        private function onTargetedOfferNotFound(_arg_1:TargetedOfferNotFoundEvent):void
        {
            _SafeStr_1506 = new MallOfferExternalInterfaceHelper(this);
        }

        public function onHabboMallOffer(_arg_1:HabboMallOffer):void
        {
            if (_arg_1.trackingState == 2)
            {
                return;
            };
            switch (_arg_1.trackingState)
            {
                case 0:
                case 5:
                case 6:
                    maximizeMallOffer(_arg_1);
                    return;
                case 2:
                    return;
                default:
                    minimizeMallOffer(_arg_1);
            };
        }

        public function maximizeMallOffer(_arg_1:HabboMallOffer):void
        {
            if (_SafeStr_1505)
            {
                return;
            };
            destroyView();
            _SafeStr_1505 = new MallOfferDialogView(this, _arg_1);
            _catalog.connection.send(new ShopTargetedOfferViewedComposer(_arg_1.targetedOfferId, 6));
        }

        public function minimizeMallOffer(_arg_1:HabboMallOffer, _arg_2:Boolean=false):void
        {
            destroyView();
            _extension = new MallOfferMinimizedView(this, _arg_1);
        }

        public function onHabboMallOfferOpened(_arg_1:HabboMallOffer):void
        {
            _catalog.connection.send(new ShopTargetedOfferViewedComposer(_arg_1.targetedOfferId, 1));
            _catalog.openCreditsHabblet();
            minimizeMallOffer(_arg_1);
        }

        public function onHabboMallOfferClosed(_arg_1:HabboMallOffer):void
        {
            _catalog.connection.send(new ShopTargetedOfferViewedComposer(_arg_1.targetedOfferId, 4));
            minimizeMallOffer(_arg_1);
        }

        public function minimizeOffer(_arg_1:TargetedOffer):void
        {
            destroyView();
            _extension = new TargetedOfferMinimizedView(this, _arg_1);
            _catalog.connection.send(new SetTargetedOfferStateComposer(_arg_1.id, 4));
        }

        public function maximizeOffer(_arg_1:TargetedOffer):void
        {
            var _local_2:String;
            if (_offerDialog)
            {
                return;
            };
            destroyView();
            if (!_arg_1.isExpired())
            {
                _local_2 = getLayoutOverride(_arg_1);
                _offerDialog = new TargetedOfferDialogView(this, _arg_1);
                if ((((!(_local_2 == null)) && (_local_2.length > 0)) && (_catalog.assets.hasAsset(_local_2))))
                {
                    _offerDialog.buildWindow(_local_2);
                }
                else
                {
                    _offerDialog.buildWindow("targeted_offer_dialog_xml");
                };
                _catalog.connection.send(new SetTargetedOfferStateComposer(_arg_1.id, 1));
            };
        }

        public function purchaseTargetedOffer(_arg_1:TargetedOffer, _arg_2:int):void
        {
            _catalog.connection.send(new PurchaseTargetedOfferComposer(_arg_1.id, _arg_2));
            _arg_1.purchased(_arg_2);
            if (_arg_1.purchaseLimit > 0)
            {
                minimizeOffer(_arg_1);
            }
            else
            {
                destroyView();
            };
        }

        public function sendLogEvent(_arg_1:String, _arg_2:String=""):void
        {
            if (((!(_catalog)) || (!(_catalog.connection))))
            {
                return;
            };
            _catalog.connection.send(new EventLogMessageComposer("TargetedOffers", "FLASH.UNKNOWN", _arg_1, _arg_2));
        }

        public function purchaseCredits(_arg_1:TargetedOffer):void
        {
            sendLogEvent("targeted.offer.open.credits.page.clicked", _arg_1.identifier);
            _catalog.openCreditsHabblet();
        }

        public function attachExtension(_arg_1:IWindow):void
        {
            _catalog.toolbar.extensionView.attachExtension("targeted_offer", _arg_1, 13);
        }

        public function showConfirmation(_arg_1:TargetedOffer, _arg_2:int):void
        {
            if (_confirmation)
            {
                return;
            };
            destroyView();
            _confirmation = new TargetedOfferPurchaseConfirmationView(this, _arg_1, _arg_2);
        }

        private function onPurseUpdate(_arg_1:PurseUpdateEvent):void
        {
            if (_offerDialog)
            {
                _offerDialog.updateButtonStates();
            };
        }

        public function destroyView():void
        {
            if (_offerDialog)
            {
                _offerDialog.dispose();
                _offerDialog = null;
            };
            if (_SafeStr_1505)
            {
                _SafeStr_1505.dispose();
                _SafeStr_1505 = null;
            };
            if (_extension)
            {
                _catalog.toolbar.extensionView.detachExtension("targeted_offer");
                _extension.dispose();
                _extension = null;
            };
            if (_confirmation)
            {
                _confirmation.dispose();
                _confirmation = null;
            };
        }

        private function getLayoutOverride(_arg_1:TargetedOffer):String
        {
            return (_catalog.getProperty(("targeted.offer.override.layout." + _arg_1.id)));
        }


    }
}


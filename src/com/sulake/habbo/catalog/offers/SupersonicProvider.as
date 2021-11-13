package com.sulake.habbo.catalog.offers
{
    import flash.external.ExternalInterface;

    public class SupersonicProvider implements IOfferProvider 
    {

        private static const CAMPAIGN_READY_CALLBACK:String = "supersonicAdsOnCampaignsReady";
        private static const CAMPAIGN_COMPLETED_CALLBACK:String = "supersonicAdsOnCampaignCompleted";
        private static const CAMPAIGN_OPEN_CALLBACK:String = "supersonicAdsOnCampaignOpen";
        private static const CAMPAIGN_CLOSE_CALLBACK:String = "supersonicAdsOnCampaignClose";
        private static const _SafeStr_1474:String = "supersonicAdsLoadCampaigns";
        private static const _SafeStr_1475:String = "supersonicAdsCamapaignEngage";

        private var _disposed:Boolean;
        private var _offerCenter:OfferCenter;
        private var _offerCount:int;
        private var _showingPopup:Boolean;
        private var _loaded:Boolean;

        public function SupersonicProvider(_arg_1:OfferCenter)
        {
            _offerCenter = _arg_1;
            if (enabled)
            {
                ExternalInterface.addCallback("supersonicAdsOnCampaignsReady", onCampaignsReady);
                ExternalInterface.addCallback("supersonicAdsOnCampaignCompleted", onCampaignCompleted);
                ExternalInterface.addCallback("supersonicAdsOnCampaignOpen", onCampaignOpen);
                ExternalInterface.addCallback("supersonicAdsOnCampaignClose", onCampaignClose);
            };
        }

        public function onCampaignsReady(_arg_1:String):void
        {
            _offerCount = int(_arg_1);
            updateVideoStatus();
        }

        public function onCampaignOpen():void
        {
            _showingPopup = true;
            updateVideoStatus();
        }

        public function onCampaignClose():void
        {
            _showingPopup = false;
            updateVideoStatus();
        }

        public function onCampaignCompleted():void
        {
        }

        public function load():void
        {
            if (((enabled) && (!(_loaded))))
            {
                try
                {
                    ExternalInterface.call("supersonicAdsLoadCampaigns");
                    _loaded = true;
                }
                catch(e:Error)
                {
                    Logger.log(("External interface not working. Could not call supersonicAdsLoadCampaigns: " + e));
                };
            };
        }

        public function showVideo():void
        {
            if (((enabled) && (_offerCount > 0)))
            {
                try
                {
                    ExternalInterface.call("supersonicAdsCamapaignEngage");
                    _offerCount--;
                }
                catch(e:Error)
                {
                    Logger.log(("External interface not working. Could not call supersonicAdsCamapaignEngage: " + e));
                };
            };
        }

        public function get videoAvailable():Boolean
        {
            return (_offerCount > 0);
        }

        public function get showingPopup():Boolean
        {
            return (_showingPopup);
        }

        private function updateVideoStatus():void
        {
            if (_offerCenter != null)
            {
                _offerCenter.updateVideoStatus();
            };
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            if (ExternalInterface.available)
            {
                ExternalInterface.addCallback("supersonicAdsOnCampaignsReady", null);
                ExternalInterface.addCallback("supersonicAdsOnCampaignCompleted", null);
                ExternalInterface.addCallback("supersonicAdsOnCampaignOpen", null);
                ExternalInterface.addCallback("supersonicAdsOnCampaignClose", null);
            };
            _offerCenter = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get enabled():Boolean
        {
            return ((_offerCenter.configuration.getBoolean("offers.supersonic.enabled")) && (ExternalInterface.available));
        }


    }
}


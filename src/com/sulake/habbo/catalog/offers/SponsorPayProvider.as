package com.sulake.habbo.catalog.offers
{
    import flash.utils.Timer;
    import flash.external.ExternalInterface;
    import flash.events.TimerEvent;

    public class SponsorPayProvider implements IOfferProvider 
    {

        private static const LOADED_CALLBACK:String = "sponsorPayLoaded";
        private static const ON_START_CALLBACK:String = "sponsorPayOnStart";
        private static const NO_OFFERS_CALLBACK:String = "sponsorPayNoOffers";
        private static const ON_CLOSE_CALLBACK:String = "sponsorPayOnClose";
        private static const ON_CONVERSION_CALLBACK:String = "sponsorPayOnConversion";
        private static const _SafeStr_1472:String = "SponsorPay.loadIntegration";
        private static const SHOW_VIDEO_FUNCTION:String = "SponsorPay.showVideo";
        private static const BACKGROUND_LOAD_FUNCTION:String = "SponsorPay.backgroundLoad";
        private static const _SafeStr_1473:int = 150000;

        private var _disposed:Boolean;
        private var _offerCenter:OfferCenter;
        private var _loaded:Boolean;
        private var _videoAvailable:Boolean;
        private var _showingPopup:Boolean;
        private var _SafeStr_1471:Timer;

        public function SponsorPayProvider(_arg_1:OfferCenter):void
        {
            _offerCenter = _arg_1;
            if (!enabled)
            {
                return;
            };
            ExternalInterface.addCallback("sponsorPayLoaded", sponsorPayLoaded);
            ExternalInterface.addCallback("sponsorPayOnStart", sponsorPayOnStart);
            ExternalInterface.addCallback("sponsorPayNoOffers", sponsorPayNoOffers);
            ExternalInterface.addCallback("sponsorPayOnClose", sponsorPayOnClose);
            ExternalInterface.addCallback("sponsorPayOnConversion", sponsorPayOnConversion);
            _SafeStr_1471 = new Timer(150000, 1);
            _SafeStr_1471.addEventListener("timer", onResetTimer);
        }

        private function onResetTimer(_arg_1:TimerEvent):void
        {
            sponsorPayOnClose();
        }

        public function load():void
        {
            if (_loaded)
            {
                sponsorPayLoaded();
                return;
            };
            if (enabled)
            {
                try
                {
                    ExternalInterface.call("SponsorPay.loadIntegration", appId);
                    _loaded = true;
                }
                catch(e:Error)
                {
                    Logger.log(("External interface not working. Could not call SponsorPay.loadIntegration: " + e));
                };
            };
        }

        private function get appId():String
        {
            return (_offerCenter.configuration.getProperty("offers.sponsorpay.appid"));
        }

        public function showVideo():void
        {
            if (((_loaded) && (enabled)))
            {
                try
                {
                    ExternalInterface.call("SponsorPay.showVideo");
                    _showingPopup = true;
                    _SafeStr_1471.reset();
                    _SafeStr_1471.start();
                    updateVideoStatus();
                }
                catch(e:Error)
                {
                    Logger.log(("External interface not working. Could not call SponsorPay.showVideo: " + e));
                };
            };
        }

        public function sponsorPayLoaded():void
        {
            if (_showingPopup)
            {
                return;
            };
            _videoAvailable = false;
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("SponsorPay.backgroundLoad");
                }
                else
                {
                    Logger.log("External interface not available. Could not call SponsorPay.backgroundLoad.");
                };
            }
            catch(e:Error)
            {
                Logger.log(("External interface not working. Could not call SponsorPay.backgroundLoad: " + e));
            };
        }

        public function sponsorPayOnStart(_arg_1:String):void
        {
            _videoAvailable = true;
            updateVideoStatus();
        }

        public function sponsorPayNoOffers():void
        {
            _videoAvailable = false;
            updateVideoStatus();
        }

        public function sponsorPayOnClose():void
        {
            _showingPopup = false;
            if (_SafeStr_1471)
            {
                _SafeStr_1471.stop();
            };
            var _local_1:int;
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("SponsorPay.backgroundLoad");
                }
                else
                {
                    Logger.log("External interface not available. Could not call SponsorPay.backgroundLoad.");
                };
            }
            catch(e:Error)
            {
                Logger.log(("External interface not working. Could not call SponsorPay.backgroundLoad: " + e));
            }
            finally
            {
                updateVideoStatus();
            };
        }

        public function sponsorPayOnConversion():void
        {
            if (_offerCenter != null)
            {
                _offerCenter.showSuccess();
            };
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
                ExternalInterface.addCallback("sponsorPayLoaded", null);
                ExternalInterface.addCallback("sponsorPayOnStart", null);
                ExternalInterface.addCallback("sponsorPayNoOffers", null);
                ExternalInterface.addCallback("sponsorPayOnClose", null);
                ExternalInterface.addCallback("sponsorPayOnConversion", null);
            };
            if (_SafeStr_1471 != null)
            {
                _SafeStr_1471.removeEventListener("timer", onResetTimer);
                _SafeStr_1471.stop();
                _SafeStr_1471 = null;
            };
            _offerCenter = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get videoAvailable():Boolean
        {
            return (_videoAvailable);
        }

        public function get showingPopup():Boolean
        {
            return (_showingPopup);
        }

        public function get enabled():Boolean
        {
            return ((!(appId == "")) && (ExternalInterface.available));
        }


    }
}


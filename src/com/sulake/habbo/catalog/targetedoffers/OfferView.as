package com.sulake.habbo.catalog.targetedoffers
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.targetedoffers.util._SafeStr_187;
    import com.sulake.core.window.components.ITextWindow;

    public class OfferView implements IDisposable 
    {

        protected var _window:IWindowContainer;
        protected var _SafeStr_1284:OfferController;
        protected var _offer:TargetedOffer;
        protected var _SafeStr_1507:Timer;
        protected var _disposed:Boolean;
        protected var _SafeStr_1508:String;

        public function OfferView(_arg_1:OfferController, _arg_2:TargetedOffer)
        {
            _SafeStr_1284 = _arg_1;
            _offer = _arg_2;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            _disposed = true;
            if (_SafeStr_1507 != null)
            {
                _SafeStr_1507.stop();
                _SafeStr_1507 = null;
            };
            if (_window != null)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        protected function startUpdateTimer():void
        {
            _SafeStr_1507 = new Timer(1000);
            _SafeStr_1507.addEventListener("timer", onUpdateTimer);
            _SafeStr_1507.start();
            updateRemainingTime();
        }

        protected function onUpdateTimer(_arg_1:TimerEvent):void
        {
            updateRemainingTime();
        }

        protected function updateRemainingTime():void
        {
            setTimeLeft(_SafeStr_187.getStringFromSeconds(_SafeStr_1284.catalog.localization, _offer.getSecondsRemaining()));
            if (_offer.getSecondsRemaining() == 0)
            {
                _SafeStr_1284.destroyView();
            };
        }

        protected function setTimeLeft(_arg_1:String):void
        {
            var _local_2:ITextWindow = ITextWindow(_window.findChildByName("txt_time_left"));
            if (!_local_2)
            {
                return;
            };
            _local_2.text = ((_SafeStr_1508 != "") ? _SafeStr_1508.replace("%timeleft%", _arg_1) : _arg_1);
        }

        protected function getLocalization(_arg_1:String, _arg_2:String=null):String
        {
            var _local_3:String = _SafeStr_1284.catalog.localization.getLocalization(_arg_1, ((_arg_2) || (_arg_1)));
            if (!_local_3)
            {
                return (null);
            };
            if (_offer)
            {
                _local_3 = _local_3.replace("%itemsleft%", _offer.purchaseLimit);
            };
            return (_local_3);
        }


    }
}


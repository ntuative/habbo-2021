package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;

    public class SpinnerCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private static const SPIN_BUTTONDOWN_HOLD_VALUE_STEP_DELAY_MS:int = 75;
        private static const _SafeStr_1622:int = 35;

        private var _catalog:HabboCatalog;
        private var _SafeStr_1623:int = 1;
        private var _SafeStr_1624:int = 1;
        private var _SafeStr_1625:int = 100;
        private var _SafeStr_1626:Timer;
        private var _SafeStr_1627:Boolean = false;
        private var _SafeStr_1628:Boolean = false;
        private var _SafeStr_1629:Boolean = false;
        private var _SafeStr_1630:int = 1;
        private var _SafeStr_1631:Array = new Array(0);
        private var _promoInfo:IWindow;

        public function SpinnerCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1626 != null)
                {
                    _SafeStr_1626.stop();
                    _SafeStr_1626 = null;
                };
                events.removeEventListener("CWSE_RESET", onRequestResetEvent);
                events.removeEventListener("CWSE_SHOW", onShowEvent);
                events.removeEventListener("CWSE_HIDE", onHideEvent);
                events.removeEventListener("CWSE_SET_MAX", onSetMaxEvent);
                events.removeEventListener("CWSE_SET_MIN", onSetMinEvent);
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("spinnerWidget");
            window.visible = false;
            if (!_catalog.multiplePurchaseEnabled)
            {
                return (true);
            };
            window.procedure = spinnerWindowProcedure;
            var _local_1:ITextFieldWindow = (window.findChildByName("text_value") as ITextFieldWindow);
            if (_local_1)
            {
                _local_1.addEventListener("WKE_KEY_UP", onInputEvent);
            };
            events.addEventListener("CWSE_RESET", onRequestResetEvent);
            events.addEventListener("CWSE_SHOW", onShowEvent);
            events.addEventListener("CWSE_HIDE", onHideEvent);
            events.addEventListener("CWSE_SET_MAX", onSetMaxEvent);
            events.addEventListener("CWSE_SET_MIN", onSetMinEvent);
            _SafeStr_1626 = new Timer(75);
            _SafeStr_1626.addEventListener("timer", onSpinnerTimerEvent);
            _promoInfo = window.findChildByName("promo.info");
            return (true);
        }

        private function refresh():void
        {
            var _local_1:int;
            _SafeStr_1623 = Math.max(_SafeStr_1623, _SafeStr_1624);
            _SafeStr_1623 = Math.min(_SafeStr_1623, _SafeStr_1625);
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_VALUE_CHANGED", _SafeStr_1623));
            setValueText(_SafeStr_1623.toString());
            if (((_promoInfo) && (_catalog.bundleDiscountEnabled)))
            {
                _local_1 = _catalog.utils.getDiscountItemsCount(_SafeStr_1623);
                window.findChildByName("discountContainer").visible = (_local_1 > 0);
                _catalog.localization.registerParameter("shop.bonus.items.count", "amount", _local_1.toString());
            };
        }

        private function onRequestResetEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            _SafeStr_1623 = _arg_1.value;
            if (_arg_1.skipSteps != null)
            {
                _SafeStr_1631 = _arg_1.skipSteps;
            };
            refresh();
        }

        private function onShowEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            window.visible = true;
        }

        private function onHideEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            window.visible = false;
        }

        private function onSetMaxEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            _SafeStr_1625 = _arg_1.value;
        }

        private function onSetMinEvent(_arg_1:CatalogWidgetSpinnerEvent):void
        {
            _SafeStr_1624 = _arg_1.value;
        }

        private function onSpinnerTimerEvent(_arg_1:TimerEvent):void
        {
            if (disposed)
            {
                return;
            };
            _SafeStr_1629 = true;
            if (_SafeStr_1627)
            {
                increaseValue();
                if ((_SafeStr_1623 - _SafeStr_1630) > 35)
                {
                    increaseValue();
                };
            };
            if (_SafeStr_1628)
            {
                decreaseValue();
                if ((_SafeStr_1630 - _SafeStr_1623) > 35)
                {
                    decreaseValue();
                };
            };
            refresh();
        }

        private function increaseValue():void
        {
            var _local_1:int = (_SafeStr_1623 + 1);
            while (_SafeStr_1631.indexOf(_local_1) != -1)
            {
                _local_1++;
            };
            _SafeStr_1623 = _local_1;
        }

        private function decreaseValue():void
        {
            var _local_1:int = (_SafeStr_1623 - 1);
            while (_SafeStr_1631.indexOf(_local_1) != -1)
            {
                _local_1--;
            };
            _SafeStr_1623 = _local_1;
        }

        private function setValueText(_arg_1:String):void
        {
            if (_window == null)
            {
                return;
            };
            if ((_window.findChildByName("text_value") is ITextFieldWindow))
            {
                if (_window.findChildByName("text_value").caption.length > 0)
                {
                    _window.findChildByName("text_value").caption = _arg_1;
                };
            }
            else
            {
                _window.findChildByName("text_value").caption = _arg_1;
            };
        }

        private function spinnerWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (!_arg_1)
            {
                return;
            };
            if (((((!(_arg_1.type == "WME_CLICK")) && (!(_arg_1.type == "WME_DOWN"))) && (!(_arg_1.type == "WME_UP"))) && (!(_arg_1.type == "WME_UP_OUTSIDE"))))
            {
                return;
            };
            switch (_arg_1.target.name)
            {
                case "button_less":
                    switch (_arg_1.type)
                    {
                        case "WME_DOWN":
                            _SafeStr_1628 = true;
                            _SafeStr_1630 = _SafeStr_1623;
                            _SafeStr_1626.start();
                            break;
                        case "WME_UP":
                        case "WME_UP_OUTSIDE":
                            _SafeStr_1628 = false;
                            _SafeStr_1626.stop();
                            break;
                        case "WME_CLICK":
                            if (!_SafeStr_1629)
                            {
                                decreaseValue();
                            };
                            refresh();
                            _SafeStr_1629 = false;
                    };
                    return;
                case "button_more":
                    switch (_arg_1.type)
                    {
                        case "WME_DOWN":
                            _SafeStr_1627 = true;
                            _SafeStr_1630 = _SafeStr_1623;
                            _SafeStr_1626.start();
                            break;
                        case "WME_UP":
                        case "WME_UP_OUTSIDE":
                            _SafeStr_1627 = false;
                            _SafeStr_1626.stop();
                            break;
                        case "WME_CLICK":
                            if (!_SafeStr_1629)
                            {
                                increaseValue();
                            };
                            refresh();
                            _SafeStr_1629 = false;
                    };
                    return;
            };
        }

        private function onInputEvent(_arg_1:WindowKeyboardEvent):void
        {
            _SafeStr_1623 = parseInt(_arg_1.target.caption);
            refresh();
        }


    }
}


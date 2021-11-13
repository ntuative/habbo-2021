package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class RedeemItemCodeCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _redeemButton:_SafeStr_101;
        private var _SafeStr_1609:ITextFieldWindow;

        public function RedeemItemCodeCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            super.dispose();
            if (_redeemButton != null)
            {
                _redeemButton.removeEventListener("WME_CLICK", onRedeem);
                _redeemButton = null;
            };
            if (_SafeStr_1609 != null)
            {
                _SafeStr_1609.removeEventListener("WKE_KEY_DOWN", windowKeyEventProcessor);
                _SafeStr_1609 = null;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _redeemButton = (_window.findChildByName("redeem") as _SafeStr_101);
            if (_redeemButton != null)
            {
                _redeemButton.addEventListener("WME_CLICK", onRedeem);
            };
            _SafeStr_1609 = (_window.findChildByName("voucher_code") as ITextFieldWindow);
            if (_SafeStr_1609 != null)
            {
                _SafeStr_1609.addEventListener("WKE_KEY_DOWN", windowKeyEventProcessor);
            };
            return (true);
        }

        private function onRedeem(_arg_1:WindowMouseEvent):void
        {
            redeem();
        }

        private function windowKeyEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            var _local_3:WindowKeyboardEvent = (_arg_1 as WindowKeyboardEvent);
            if (_local_3.charCode == 13)
            {
                redeem();
            };
        }

        private function redeem():void
        {
            var input:IWindow = _window.findChildByName("voucher_code");
            if (input != null)
            {
                var voucher:String = input.caption;
                if (voucher.length > 0)
                {
                    page.viewer.catalog.redeemVoucher(voucher);
                    input.caption = "";
                }
                else
                {
                    page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}", "${catalog.voucher.empty.desc}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                };
            };
        }


    }
}


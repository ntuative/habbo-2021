package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MadMoneyCatalogWidget extends CatalogWidget implements ICatalogWidget
    {

        private var _buyButton:_SafeStr_101;

        public function MadMoneyCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            super.dispose();
            if (_buyButton != null)
            {
                _buyButton.removeEventListener("WME_CLICK", eventProc);
                _buyButton = null;
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _buyButton = (_window.findChildByName("ctlg_madmoney_button") as _SafeStr_101);
            if (_buyButton != null)
            {
            };
            return (true);
        }

        private function eventProc(_arg_1:WindowMouseEvent):void
        {
            var event:WindowMouseEvent = _arg_1;
            page.viewer.catalog.windowManager.alert("TODO", "Fix in MadMoneyCatalogWidget.as", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }


    }
}
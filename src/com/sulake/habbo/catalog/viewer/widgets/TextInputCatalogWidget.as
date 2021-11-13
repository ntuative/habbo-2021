package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;

    public class TextInputCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _SafeStr_1632:ITextFieldWindow;

        public function TextInputCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _SafeStr_1632 = (_window.findChildByName("input_text") as ITextFieldWindow);
            if (_SafeStr_1632 != null)
            {
                _SafeStr_1632.addEventListener("WKE_KEY_UP", onKey);
            };
            return (true);
        }

        private function onKey(_arg_1:WindowKeyboardEvent):void
        {
            if (_SafeStr_1632 == null)
            {
                return;
            };
            events.dispatchEvent(new TextInputEvent(_SafeStr_1632.text));
        }


    }
}


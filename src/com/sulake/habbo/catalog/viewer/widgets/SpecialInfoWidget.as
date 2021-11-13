package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class SpecialInfoWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function SpecialInfoWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("specialInfoWidget");
            _window.findChildByName("ctlg_special_txt").caption = "";
            events.addEventListener("SELECT_PRODUCT", onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _window.visible = false;
        }


    }
}
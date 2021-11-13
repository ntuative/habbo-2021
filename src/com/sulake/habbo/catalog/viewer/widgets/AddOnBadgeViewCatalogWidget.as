package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.widgets.IBadgeImageWidget;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class AddOnBadgeViewCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function AddOnBadgeViewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }

        override public function dispose():void
        {
            if (!disposed)
            {
                events.removeEventListener("SELECT_PRODUCT", onSelectProduct);
                super.dispose();
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            attachWidgetView("addOnBadgeViewWidget");
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            return (true);
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            var _local_2:IBadgeImageWidget;
            if (((!(disposed)) && (_arg_1.offer.badgeCode)))
            {
                _local_2 = (IWidgetWindow(_window.findChildByName("badge")).widget as IBadgeImageWidget);
                if (_local_2 != null)
                {
                    _local_2.badgeId = _arg_1.offer.badgeCode;
                };
            };
        }


    }
}
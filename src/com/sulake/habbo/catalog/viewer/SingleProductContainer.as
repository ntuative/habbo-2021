package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.HabboCatalog;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.IWindowContainer;

    public class SingleProductContainer extends ProductContainer 
    {

        public function SingleProductContainer(_arg_1:IPurchasableOffer, _arg_2:Vector.<IProduct>, _arg_3:HabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void
        {
            var _local_3:IProduct = firstProduct;
            var _local_4:BitmapData = _local_3.initIcon(this, this, this, (offer as IPurchasableOffer), _icon, _arg_2, onPreviewImageReady);
            this.setIconImage(_local_4, true);
        }

        public function enableLimitedItemLayout():void
        {
            _SafeStr_570.findChildByName("unique_item_background_bitmap").visible = true;
            var _local_1:IWidgetWindow = IWidgetWindow(_SafeStr_570.findChildByName("unique_item_overlay_container"));
            var _local_2:ILimitedItemGridOverlayWidget = ILimitedItemGridOverlayWidget(_local_1.widget);
            _local_1.visible = true;
            _local_2.serialNumber = firstProduct.uniqueLimitedItemSeriesSize;
            _local_2.animated = true;
            if (firstProduct.uniqueLimitedItemsLeft == 0)
            {
                _SafeStr_570.findChildByName("unique_item_sold_out_bitmap").visible = true;
            }
            else
            {
                _SafeStr_570.findChildByName("unique_item_sold_out_bitmap").visible = false;
            };
        }

        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            if (((!(disposed)) && (!(offer.page.viewer.catalog == null))))
            {
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null)
                {
                    catalog.setImageFromAsset(_icon, _local_2.assetName, null);
                };
            };
        }

        override public function set view(_arg_1:IWindowContainer):void
        {
            super.view = _arg_1;
            if (offer.product.isUniqueLimitedItem)
            {
                (offer.productContainer as SingleProductContainer).enableLimitedItemLayout();
            };
        }


    }
}


package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;

    public class ExtraInfoBonusBadgeItem extends ExtraInfoListItem implements IGetImageListener 
    {

        private var _catalog:HabboCatalog;

        public function ExtraInfoBonusBadgeItem(_arg_1:int, _arg_2:ExtraInfoItemData, _arg_3:HabboCatalog)
        {
            super(null, _arg_1, _arg_2, 0);
            _catalog = _arg_3;
        }

        override public function getRenderedWindow():IWindowContainer
        {
            return (null);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}
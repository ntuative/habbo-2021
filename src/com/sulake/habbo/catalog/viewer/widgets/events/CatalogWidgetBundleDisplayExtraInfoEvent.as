package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;

    public class CatalogWidgetBundleDisplayExtraInfoEvent extends Event 
    {

        public static const RESET:String = "CWPPEIE_RESET";
        public static const HIDE:String = "CWPPEIE_HIDE";
        public static const ITEM_CLICKED:String = "CWPPEIE_ITEM_CLICKED";

        private var _id:int;
        private var _data:ExtraInfoItemData;

        public function CatalogWidgetBundleDisplayExtraInfoEvent(_arg_1:String, _arg_2:ExtraInfoItemData=null, _arg_3:int=-1)
        {
            super(_arg_1);
            _id = _arg_3;
            _data = _arg_2;
        }

        public function get id():int
        {
            return (_id);
        }

        public function get data():ExtraInfoItemData
        {
            return (_data);
        }


    }
}
package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
    import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;

    public class UpdateableExtraInfoListItem extends ExtraInfoListItem 
    {

        public function UpdateableExtraInfoListItem(_arg_1:BundlePurchaseExtraInfoWidget, _arg_2:int, _arg_3:ExtraInfoItemData, _arg_4:int=0, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function update(_arg_1:ExtraInfoItemData):void
        {
            data = _arg_1;
        }


    }
}
package com.sulake.habbo.inventory.items
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.object.data.StuffDataBase;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class CreditTradingItem extends GroupItem 
    {

        private static const THUMB_WINDOW_LAYOUT:String = "inventory_thumb_credits_xml";

        private var _SafeStr_2760:int;
        private var _assets:IAssetLibrary;

        public function CreditTradingItem(_arg_1:FurniModel, _arg_2:IAssetLibrary, _arg_3:IRoomEngine, _arg_4:int)
        {
            var _local_5:BitmapData = null;
            _SafeStr_2760 = _arg_4;
            _assets = _arg_2;
            _local_5 = getItemIcon();
            super(_arg_1, type, category, _arg_3, new StuffDataBase(), extra, _local_5, false, "center");
        }

        override public function dispose():void
        {
            _assets = null;
            super.dispose();
        }

        public function getItemIcon():BitmapData
        {
            if (!_assets)
            {
                return (null);
            };
            var _local_1:IAsset = _assets.getAssetByName("inventory_furni_icon_credits");
            return ((_local_1 != null) ? (_local_1.content as BitmapData).clone() : null);
        }

        public function getItemTooltipText():String
        {
            return ("${purse_coins}");
        }

        public function getTotalCreditValue():int
        {
            return (_SafeStr_2760);
        }

        override public function get isGroupable():Boolean
        {
            return (true);
        }

        override public function getTotalCount():int
        {
            return (getTotalCreditValue());
        }

        override public function getUnlockedCount():int
        {
            return (getTotalCreditValue());
        }

        override protected function createWindow():void
        {
            _window = _SafeStr_1275.createItemWindow("inventory_thumb_credits_xml");
        }

        override public function getMinimumItemsToShowCounter():int
        {
            return (1);
        }


    }
}


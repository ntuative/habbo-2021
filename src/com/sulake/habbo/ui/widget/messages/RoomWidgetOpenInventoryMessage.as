package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4198:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
        public static const INVENTORY_EFFECTS:String = "inventory_effects";
        public static const INVENTORY_BADGES:String = "inventory_badges";
        public static const INVENTORY_CLOTHES:String = "inventory_clothes";
        public static const INVENTORY_FURNITURE:String = "inventory_furniture";

        private var _inventoryType:String;

        public function RoomWidgetOpenInventoryMessage(_arg_1:String)
        {
            super("RWGOI_MESSAGE_OPEN_INVENTORY");
            _inventoryType = _arg_1;
        }

        public function get inventoryType():String
        {
            return (_inventoryType);
        }


    }
}


package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4185:String = "RWFCRM_REDEEM";

        private var _objectId:int;

        public function RoomWidgetCreditFurniRedeemMessage(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            _objectId = _arg_2;
        }

        public function get objectId():int
        {
            return (_objectId);
        }


    }
}


package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetCreditFurniUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const UPDATE_CREDIT_FURNI:String = "RWCFUE_CREDIT_FURNI_UPDATE";

        private var _objectId:int;
        private var _creditValue:Number;

        public function RoomWidgetCreditFurniUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            _creditValue = _arg_3;
            _objectId = _arg_2;
        }

        public function get creditValue():Number
        {
            return (_creditValue);
        }

        public function get objectId():int
        {
            return (_objectId);
        }


    }
}
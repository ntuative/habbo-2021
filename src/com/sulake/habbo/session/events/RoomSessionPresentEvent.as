package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPresentEvent extends RoomSessionEvent 
    {

        public static const ROOM_SESSION_PRESENT_OPENED:String = "RSPE_PRESENT_OPENED";

        private var _classId:int = 0;
        private var _itemType:String = "";
        private var _productCode:String;
        private var _placedItemId:int = 0;
        private var _placedItemType:String = "";
        private var _placedInRoom:Boolean;
        private var _petFigureString:String;

        public function RoomSessionPresentEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:int, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:String, _arg_8:Boolean, _arg_9:String, _arg_10:Boolean=false, _arg_11:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_10, _arg_11);
            _classId = _arg_3;
            _itemType = _arg_4;
            _productCode = _arg_5;
            _placedItemId = _arg_6;
            _placedItemType = _arg_7;
            _placedInRoom = _arg_8;
            _petFigureString = _arg_9;
        }

        public function get classId():int
        {
            return (_classId);
        }

        public function get itemType():String
        {
            return (_itemType);
        }

        public function get productCode():String
        {
            return (_productCode);
        }

        public function get placedItemId():int
        {
            return (_placedItemId);
        }

        public function get placedInRoom():Boolean
        {
            return (_placedInRoom);
        }

        public function get placedItemType():String
        {
            return (_placedItemType);
        }

        public function get petFigureString():String
        {
            return (_petFigureString);
        }


    }
}
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const VISITOR_QUEUE_STATUS:String = "RWRQUE_VISITOR_QUEUE_STATUS";
        public static const SPECTATOR_QUEUE_STATUS:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";

        private var _position:int;
        private var _hasHabboClub:Boolean;
        private var _isActive:Boolean;
        private var _isClubQueue:Boolean;

        public function RoomWidgetRoomQueueUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            _position = _arg_2;
            _hasHabboClub = _arg_3;
            _isActive = _arg_4;
            _isClubQueue = _arg_5;
        }

        public function get position():int
        {
            return (_position);
        }

        public function get hasHabboClub():Boolean
        {
            return (_hasHabboClub);
        }

        public function get isActive():Boolean
        {
            return (_isActive);
        }

        public function get isClubQueue():Boolean
        {
            return (_isClubQueue);
        }


    }
}
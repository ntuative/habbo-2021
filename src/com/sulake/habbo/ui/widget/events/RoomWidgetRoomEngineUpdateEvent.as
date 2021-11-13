package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomEngineUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const GAME_MODE:String = "RWREUE_GAME_MODE";
        public static const NORMAL_MODE:String = "RWREUE_NORMAL_MODE";

        private var _roomId:int = 0;

        public function RoomWidgetRoomEngineUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _roomId = _arg_2;
        }

        public function get roomId():int
        {
            return (_roomId);
        }


    }
}
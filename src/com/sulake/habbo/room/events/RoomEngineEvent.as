package com.sulake.habbo.room.events
{
    import flash.events.Event;

    public class RoomEngineEvent extends Event 
    {

        public static const ROOM_ENGINE_INITIALIZED:String = "REE_ENGINE_INITIALIZED";
        public static const ROOM_INITIALIZED:String = "REE_INITIALIZED";
        public static const ROOM_DISPOSED:String = "REE_DISPOSED";
        public static const ROOM_ENGINE_GAME_MODE:String = "REE_GAME_MODE";
        public static const ROOM_ENGINE_NORMAL_MODE:String = "REE_NORMAL_MODE";
        public static const ROOM_OBJECTS_INITIALIZED:String = "REE_OBJECTS_INITIALIZED";
        public static const ROOM_ZOOMED:String = "REE_ROOM_ZOOMED";

        private var _roomId:int;

        public function RoomEngineEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
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
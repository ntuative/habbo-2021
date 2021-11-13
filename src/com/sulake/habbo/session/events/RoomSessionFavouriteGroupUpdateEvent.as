package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent 
    {

        public static const _SafeStr_3686:String = "rsfgue_favourite_group_update";

        private var _roomIndex:int;
        private var _habboGroupId:int;
        private var _habboGroupName:String;
        private var _status:int;

        public function RoomSessionFavouriteGroupUpdateEvent(_arg_1:IRoomSession, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("rsfgue_favourite_group_update", _arg_1, _arg_6, _arg_7);
            _roomIndex = _arg_2;
            _habboGroupId = _arg_3;
            _habboGroupName = _arg_5;
            _status = _arg_4;
        }

        public function get roomIndex():int
        {
            return (_roomIndex);
        }

        public function get habboGroupId():int
        {
            return (_habboGroupId);
        }

        public function get habboGroupName():String
        {
            return (_habboGroupName);
        }

        public function get status():int
        {
            return (_status);
        }


    }
}


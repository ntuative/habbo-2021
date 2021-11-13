package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomToObjectEvent;
    import com.sulake.room.utils.IVector3d;

    public class RoomToObjectOwnAvatarMoveEvent extends RoomToObjectEvent 
    {

        public static const MOVE_TO:String = "ROAME_MOVE_TO";

        private var _targetLoc:IVector3d;

        public function RoomToObjectOwnAvatarMoveEvent(_arg_1:String, _arg_2:IVector3d, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _targetLoc = _arg_2;
        }

        public function get targetLoc():IVector3d
        {
            return (_targetLoc);
        }


    }
}
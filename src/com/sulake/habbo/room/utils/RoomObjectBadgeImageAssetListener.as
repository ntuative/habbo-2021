package com.sulake.habbo.room.utils
{
    import com.sulake.room.object.IRoomObjectController;

        public class RoomObjectBadgeImageAssetListener 
    {

        private var _object:IRoomObjectController;
        private var _groupBadge:Boolean;

        public function RoomObjectBadgeImageAssetListener(_arg_1:IRoomObjectController, _arg_2:Boolean)
        {
            _object = _arg_1;
            _groupBadge = _arg_2;
        }

        public function get object():IRoomObjectController
        {
            return (_object);
        }

        public function get groupBadge():Boolean
        {
            return (_groupBadge);
        }


    }
}
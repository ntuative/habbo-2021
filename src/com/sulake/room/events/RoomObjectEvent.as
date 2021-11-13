package com.sulake.room.events
{
    import flash.events.Event;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectEvent extends Event 
    {

        private var _object:IRoomObject;

        public function RoomObjectEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _object = _arg_2;
        }

        public function get object():IRoomObject
        {
            return (_object);
        }

        public function get objectId():int
        {
            if (_object != null)
            {
                return (_object.getId());
            };
            return (-1);
        }

        public function get objectType():String
        {
            if (_object != null)
            {
                return (_object.getType());
            };
            return (null);
        }


    }
}
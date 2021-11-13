package com.sulake.habbo.room.events
{
    public class RoomEngineObjectPlacedOnUserEvent extends RoomEngineObjectEvent 
    {

        private var _droppedObjectId:int;
        private var _droppedObjectCategory:int;

        public function RoomEngineObjectPlacedOnUserEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_7, _arg_8);
            _droppedObjectId = droppedObjectId;
            _droppedObjectCategory = _arg_6;
        }

        public function get droppedObjectId():int
        {
            return (_droppedObjectId);
        }

        public function get droppedObjectCategory():int
        {
            return (_droppedObjectCategory);
        }


    }
}
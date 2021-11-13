package com.sulake.habbo.room.utils
{
        public class RoomData 
    {

        private var _roomId:int;
        private var _data:XML;
        private var _floorType:String = null;
        private var _wallType:String = null;
        private var _landscapeType:String = null;

        public function RoomData(_arg_1:int, _arg_2:XML)
        {
            _roomId = _arg_1;
            _data = _arg_2;
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function get data():XML
        {
            return (_data);
        }

        public function get floorType():String
        {
            return (_floorType);
        }

        public function set floorType(_arg_1:String):void
        {
            _floorType = _arg_1;
        }

        public function get wallType():String
        {
            return (_wallType);
        }

        public function set wallType(_arg_1:String):void
        {
            _wallType = _arg_1;
        }

        public function get landscapeType():String
        {
            return (_landscapeType);
        }

        public function set landscapeType(_arg_1:String):void
        {
            _landscapeType = _arg_1;
        }


    }
}
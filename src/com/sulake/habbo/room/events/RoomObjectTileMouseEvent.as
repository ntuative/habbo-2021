package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectMouseEvent;
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectTileMouseEvent extends RoomObjectMouseEvent 
    {

        private var _tileX:Number;
        private var _tileY:Number;
        private var _tileZ:Number;

        public function RoomObjectTileMouseEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:String, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Boolean=false, _arg_8:Boolean=false, _arg_9:Boolean=false, _arg_10:Boolean=false, _arg_11:Boolean=false, _arg_12:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12);
            _tileX = _arg_4;
            _tileY = _arg_5;
            _tileZ = _arg_6;
        }

        public function get tileX():Number
        {
            return (_tileX);
        }

        public function get tileY():Number
        {
            return (_tileY);
        }

        public function get tileZ():Number
        {
            return (_tileZ);
        }

        public function get tileXAsInt():int
        {
            return (_tileX + 0.499);
        }

        public function get tileYAsInt():int
        {
            return (_tileY + 0.499);
        }

        public function get tileZAsInt():int
        {
            return (_tileZ + 0.499);
        }


    }
}
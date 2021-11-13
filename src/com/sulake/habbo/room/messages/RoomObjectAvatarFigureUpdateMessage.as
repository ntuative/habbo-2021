package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _figure:String;
        private var _race:String;
        private var _gender:String;
        private var _isRiding:Boolean;

        public function RoomObjectAvatarFigureUpdateMessage(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false)
        {
            _figure = _arg_1;
            _gender = _arg_2;
            _race = _arg_3;
            _isRiding = _arg_4;
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get race():String
        {
            return (_race);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get isRiding():Boolean
        {
            return (_isRiding);
        }


    }
}
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _effect:int;
        private var _delayMilliSeconds:int;

        public function RoomObjectAvatarEffectUpdateMessage(_arg_1:int=0, _arg_2:int=0)
        {
            _effect = _arg_1;
            _delayMilliSeconds = _arg_2;
        }

        public function get effect():int
        {
            return (_effect);
        }

        public function get delayMilliSeconds():int
        {
            return (_delayMilliSeconds);
        }


    }
}
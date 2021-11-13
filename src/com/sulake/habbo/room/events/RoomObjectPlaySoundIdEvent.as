package com.sulake.habbo.room.events
{
    import com.sulake.room.object.IRoomObject;

    public class RoomObjectPlaySoundIdEvent extends RoomObjectFurnitureActionEvent 
    {

        public static const PLAY_SOUND:String = "ROPSIE_PLAY_SOUND";
        public static const PLAY_SOUND_AT_PITCH:String = "ROPSIE_PLAY_SOUND_AT_PITCH";

        private var _soundId:String;
        private var _pitch:Number;

        public function RoomObjectPlaySoundIdEvent(_arg_1:String, _arg_2:IRoomObject, _arg_3:String, _arg_4:Number=1, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_5, _arg_6);
            _soundId = _arg_3;
            _pitch = _arg_4;
        }

        public function get soundId():String
        {
            return (_soundId);
        }

        public function get pitch():Number
        {
            return (_pitch);
        }


    }
}
package com.sulake.habbo.room.events
{
    public class RoomEngineObjectSamplePlaybackEvent extends RoomEngineObjectEvent 
    {

        public static const ROOM_OBJECT_INITIALIZED:String = "REOSPE_ROOM_OBJECT_INITIALIZED";
        public static const ROOM_OBJECT_DISPOSED:String = "REOSPE_ROOM_OBJECT_DISPOSED";
        public static const PLAY_SAMPLE:String = "REOSPE_PLAY_SAMPLE";
        public static const CHANGE_PITCH:String = "REOSPE_CHANGE_PITCH";

        private var _sampleId:int;
        private var _pitch:Number;

        public function RoomEngineObjectSamplePlaybackEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Number=1, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            _sampleId = _arg_5;
            _pitch = _arg_6;
        }

        public function get sampleId():int
        {
            return (_sampleId);
        }

        public function get pitch():Number
        {
            return (_pitch);
        }


    }
}
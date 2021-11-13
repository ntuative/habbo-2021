package com.sulake.habbo.room.messages
{
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.utils.Vector3d;

    public class RoomObjectTileCursorUpdateMessage extends RoomObjectUpdateMessage 
    {

        private var _height:Number;
        private var _sourceEventId:String;
        private var _visible:Boolean;
        private var _toggleVisibility:Boolean;

        public function RoomObjectTileCursorUpdateMessage(_arg_1:Vector3d, _arg_2:Number, _arg_3:Boolean, _arg_4:String, _arg_5:Boolean=false)
        {
            super(_arg_1, null);
            _height = _arg_2;
            _visible = _arg_3;
            _sourceEventId = _arg_4;
            _toggleVisibility = _arg_5;
        }

        public function get height():Number
        {
            return (_height);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get sourceEventId():String
        {
            return (_sourceEventId);
        }

        public function get toggleVisibility():Boolean
        {
            return (_toggleVisibility);
        }


    }
}
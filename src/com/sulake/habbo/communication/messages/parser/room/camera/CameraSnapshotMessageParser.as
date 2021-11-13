package com.sulake.habbo.communication.messages.parser.room.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CameraSnapshotMessageParser implements IMessageParser 
    {

        private var _roomType:String = "";
        private var _roomId:int = 0;


        public function get roomType():String
        {
            return (_roomType);
        }

        public function get roomId():int
        {
            return (_roomId);
        }

        public function flush():Boolean
        {
            _roomType = "";
            _roomId = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _roomType = _arg_1.readString();
            _roomId = _arg_1.readInteger();
            return (true);
        }


    }
}
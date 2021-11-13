package com.sulake.habbo.communication.messages.incoming.room.engine
{
        public class AvatarActionMessageData 
    {

        private var _actionType:String;
        private var _actionParameter:String;

        public function AvatarActionMessageData(_arg_1:String, _arg_2:String)
        {
            _actionType = _arg_1;
            _actionParameter = _arg_2;
        }

        public function get actionType():String
        {
            return (_actionType);
        }

        public function get actionParameter():String
        {
            return (_actionParameter);
        }

        public function toString():String
        {
            return ((_actionType + ":") + _actionParameter);
        }


    }
}
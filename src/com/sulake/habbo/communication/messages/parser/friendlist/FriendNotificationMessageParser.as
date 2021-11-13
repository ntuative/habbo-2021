package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendNotificationMessageParser implements IMessageParser 
    {

        private var _typeCode:int = -1;
        private var _avatarId:String;
        private var _message:String;


        public function get typeCode():int
        {
            return (_typeCode);
        }

        public function get avatarId():String
        {
            return (_avatarId);
        }

        public function get message():String
        {
            return (_message);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _avatarId = _arg_1.readString();
            _typeCode = _arg_1.readInteger();
            _message = _arg_1.readString();
            return (true);
        }


    }
}
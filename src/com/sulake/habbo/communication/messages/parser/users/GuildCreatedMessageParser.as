package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildCreatedMessageParser implements IMessageParser 
    {

        private var _baseRoomId:int;
        private var _groupId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _baseRoomId = _arg_1.readInteger();
            _groupId = _arg_1.readInteger();
            return (true);
        }

        public function get baseRoomId():int
        {
            return (_baseRoomId);
        }

        public function get groupId():int
        {
            return (_groupId);
        }


    }
}
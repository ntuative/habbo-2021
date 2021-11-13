package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildMemberFurniCountInHQMessageParser implements IMessageParser 
    {

        private var _userId:int;
        private var _furniCount:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _userId = _arg_1.readInteger();
            _furniCount = _arg_1.readInteger();
            return (true);
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get furniCount():int
        {
            return (_furniCount);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HabboGroupDeactivatedMessageParser implements IMessageParser 
    {

        private var _groupId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _groupId = _arg_1.readInteger();
            return (true);
        }

        public function get groupId():int
        {
            return (_groupId);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestCancelledMessageParser implements IMessageParser 
    {

        private var _expired:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _expired = _arg_1.readBoolean();
            return (true);
        }

        public function get expired():Boolean
        {
            return (_expired);
        }


    }
}
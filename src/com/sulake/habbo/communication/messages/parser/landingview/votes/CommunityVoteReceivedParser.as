package com.sulake.habbo.communication.messages.parser.landingview.votes
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CommunityVoteReceivedParser implements IMessageParser 
    {

        private var _acknowledged:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _acknowledged = _arg_1.readBoolean();
            return (true);
        }

        public function get acknowledged():Boolean
        {
            return (_acknowledged);
        }


    }
}
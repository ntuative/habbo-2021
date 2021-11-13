package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IssueDeletedMessageParser implements IMessageParser 
    {

        private var _issueId:int;


        public function get issueId():int
        {
            return (_issueId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _issueId = parseInt(_arg_1.readString());
            return (true);
        }


    }
}
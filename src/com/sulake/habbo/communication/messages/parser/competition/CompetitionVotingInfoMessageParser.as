package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompetitionVotingInfoMessageParser implements IMessageParser 
    {

        private var _goalId:int;
        private var _goalCode:String;
        private var _resultCode:int;
        private var _votesRemaining:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _goalId = _arg_1.readInteger();
            _goalCode = _arg_1.readString();
            _resultCode = _arg_1.readInteger();
            _votesRemaining = _arg_1.readInteger();
            return (true);
        }

        public function get goalId():int
        {
            return (_goalId);
        }

        public function get goalCode():String
        {
            return (_goalCode);
        }

        public function get isVotingAllowedForUser():Boolean
        {
            return (_resultCode == 0);
        }

        public function get votesRemaining():int
        {
            return (_votesRemaining);
        }

        public function get resultCode():int
        {
            return (_resultCode);
        }


    }
}
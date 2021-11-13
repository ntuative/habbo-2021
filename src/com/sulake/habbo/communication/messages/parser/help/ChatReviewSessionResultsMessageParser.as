package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ChatReviewSessionResultsMessageParser implements IMessageParser 
    {

        private var _winningVoteCode:int;
        private var _ownVoteCode:int;
        private var _finalStatus:Array;


        public function flush():Boolean
        {
            _winningVoteCode = -1;
            _ownVoteCode = -1;
            _finalStatus = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _winningVoteCode = _arg_1.readInteger();
            _ownVoteCode = _arg_1.readInteger();
            _finalStatus = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _finalStatus.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }

        public function get winningVoteCode():int
        {
            return (_winningVoteCode);
        }

        public function get ownVoteCode():int
        {
            return (_ownVoteCode);
        }

        public function get finalStatus():Array
        {
            return (_finalStatus);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.competition
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IsUserPartOfCompetitionMessageParser implements IMessageParser 
    {

        private var _isPartOf:Boolean;
        private var _targetId:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isPartOf = _arg_1.readBoolean();
            _targetId = _arg_1.readInteger();
            return (true);
        }

        public function get isPartOf():Boolean
        {
            return (_isPartOf);
        }

        public function get targetId():int
        {
            return (_targetId);
        }


    }
}
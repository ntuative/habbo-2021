package com.sulake.habbo.communication.messages.parser.vault
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IncomeRewardClaimResponseMessageEventParser implements IMessageParser 
    {

        private var _rewardCategory:int;
        private var _result:Boolean;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _rewardCategory = _arg_1.readByte();
            _result = _arg_1.readBoolean();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get rewardCategory():int
        {
            return (_rewardCategory);
        }

        public function get result():Boolean
        {
            return (_result);
        }


    }
}
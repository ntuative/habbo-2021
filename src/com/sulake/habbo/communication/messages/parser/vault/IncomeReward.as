package com.sulake.habbo.communication.messages.parser.vault
{
        public class IncomeReward 
    {

        private var _rewardCategory:int;
        private var _rewardType:int;
        private var _amount:int;
        private var _productCode:String;

        public function IncomeReward(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String)
        {
            _rewardCategory = _arg_1;
            _rewardType = _arg_2;
            _amount = _arg_3;
            _productCode = _arg_4;
        }

        public function get rewardCategory():int
        {
            return (_rewardCategory);
        }

        public function get rewardType():int
        {
            return (_rewardType);
        }

        public function get amount():int
        {
            return (_amount);
        }

        public function get productCode():String
        {
            return (_productCode);
        }


    }
}
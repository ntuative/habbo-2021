package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BonusRareInfoMessageParser implements IMessageParser 
    {

        private var _productType:String;
        private var _productClassId:int;
        private var _totalCoinsForBonus:int;
        private var _coinsStillRequiredToBuy:int;


        public function flush():Boolean
        {
            _totalCoinsForBonus = -1;
            _coinsStillRequiredToBuy = -1;
            _productType = "";
            _productClassId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _productType = _arg_1.readString();
            _productClassId = _arg_1.readInteger();
            _totalCoinsForBonus = _arg_1.readInteger();
            _coinsStillRequiredToBuy = _arg_1.readInteger();
            return (true);
        }

        public function get totalCoinsForBonus():int
        {
            return (_totalCoinsForBonus);
        }

        public function get coinsStillRequiredToBuy():int
        {
            return (_coinsStillRequiredToBuy);
        }

        public function get productType():String
        {
            return (_productType);
        }

        public function get productClassId():int
        {
            return (_productClassId);
        }


    }
}
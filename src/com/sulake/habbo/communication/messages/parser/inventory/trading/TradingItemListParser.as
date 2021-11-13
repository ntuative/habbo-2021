package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;

        public class TradingItemListParser implements IMessageParser 
    {

        private var _firstUserID:int;
        private var _firstUserItemArray:Array;
        private var _firstUserNumItems:int;
        private var _firstUserNumCredits:int;
        private var _secondUserID:int;
        private var _secondUserItemArray:Array;
        private var _secondUserNumItems:int;
        private var _secondUserNumCredits:int;


        public function get firstUserID():int
        {
            return (_firstUserID);
        }

        public function get firstUserItemArray():Array
        {
            return (_firstUserItemArray);
        }

        public function get firstUserNumItems():int
        {
            return (_firstUserNumItems);
        }

        public function get firstUserNumCredits():int
        {
            return (_firstUserNumCredits);
        }

        public function get secondUserID():int
        {
            return (_secondUserID);
        }

        public function get secondUserItemArray():Array
        {
            return (_secondUserItemArray);
        }

        public function get secondUserNumItems():int
        {
            return (_secondUserNumItems);
        }

        public function get secondUserNumCredits():int
        {
            return (_secondUserNumCredits);
        }

        public function flush():Boolean
        {
            _firstUserID = -1;
            _firstUserItemArray = null;
            _firstUserNumItems = 0;
            _firstUserNumCredits = 0;
            _secondUserID = -1;
            _secondUserItemArray = null;
            _secondUserNumItems = 0;
            _secondUserNumCredits = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _firstUserID = _arg_1.readInteger();
            _firstUserItemArray = [];
            if (!parseItemData(_arg_1, _firstUserItemArray))
            {
                return (false);
            };
            _firstUserNumItems = _arg_1.readInteger();
            _firstUserNumCredits = _arg_1.readInteger();
            _secondUserID = _arg_1.readInteger();
            _secondUserItemArray = [];
            if (!parseItemData(_arg_1, _secondUserItemArray))
            {
                return (false);
            };
            _secondUserNumItems = _arg_1.readInteger();
            _secondUserNumCredits = _arg_1.readInteger();
            return (true);
        }

        private function parseItemData(_arg_1:IMessageDataWrapper, _arg_2:Array):Boolean
        {
            var _local_3:int;
            _local_3 = _arg_1.readInteger();
            while (_local_3 > 0)
            {
                _arg_2.push(new ItemDataStructure(_arg_1));
                _local_3--;
            };
            return (true);
        }


    }
}
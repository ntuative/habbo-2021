package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class WeeklyGameRewardParser implements IMessageParser 
    {

        private var _gameTypeId:int;
        private var _products:Array = [];
        private var _minutesUntilNextWeek:int;
        private var _rewardingOn:Boolean;


        public function get gameTypeId():int
        {
            return (_gameTypeId);
        }

        public function get products():Array
        {
            return (_products);
        }

        public function get minutesUntilNextWeek():int
        {
            return (_minutesUntilNextWeek);
        }

        public function get rewardingOn():Boolean
        {
            return (_rewardingOn);
        }

        public function flush():Boolean
        {
            _gameTypeId = -1;
            _products = [];
            _minutesUntilNextWeek = 0;
            _rewardingOn = true;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            _gameTypeId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _products.push(new CatalogPageMessageProductData(_arg_1));
                _local_2++;
            };
            _minutesUntilNextWeek = _arg_1.readInteger();
            _rewardingOn = _arg_1.readBoolean();
            return (true);
        }


    }
}
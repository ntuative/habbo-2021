package com.sulake.habbo.communication.messages.parser.marketplace
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.communication.messages.parser.room.engine._SafeStr_75;
    import com.sulake.habbo.room.object.data._SafeStr_80;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class MarketPlaceOffersParser implements IMessageParser 
    {

        public static const _SafeStr_2062:int = 1;
        public static const _SafeStr_2063:int = 2;
        public static const _SafeStr_2064:int = 3;

        private const _SafeStr_2065:int = 500;

        private var _offers:Array;
        private var _totalItemsFound:int;


        public function flush():Boolean
        {
            _offers = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_12:int;
            var _local_14:int;
            var _local_2:int;
            var _local_4:int;
            var _local_11:int;
            var _local_8:int;
            var _local_13:int;
            var _local_6:int;
            var _local_7:int;
            var _local_3:MarketPlaceOffer;
            _offers = [];
            var _local_5:String = "";
            var _local_10:IStuffData;
            var _local_9:int = _arg_1.readInteger();
            _local_7 = 0;
            while (_local_7 < _local_9)
            {
                _local_10 = null;
                _local_12 = _arg_1.readInteger();
                _local_14 = _arg_1.readInteger();
                _local_2 = _arg_1.readInteger();
                if (_local_2 == 1)
                {
                    _local_4 = _arg_1.readInteger();
                    _local_10 = _SafeStr_75.parseStuffData(_arg_1);
                }
                else
                {
                    if (_local_2 == 2)
                    {
                        _local_4 = _arg_1.readInteger();
                        _local_5 = _arg_1.readString();
                    }
                    else
                    {
                        if (_local_2 == 3)
                        {
                            _local_4 = _arg_1.readInteger();
                            _local_10 = _SafeStr_80.getStuffDataWrapperForType(0);
                            _local_10.uniqueSerialNumber = _arg_1.readInteger();
                            _local_10.uniqueSeriesSize = _arg_1.readInteger();
                            _local_2 = 1;
                        };
                    };
                };
                _local_11 = _arg_1.readInteger();
                _local_8 = _arg_1.readInteger();
                _local_13 = _arg_1.readInteger();
                _local_6 = _arg_1.readInteger();
                _local_3 = new MarketPlaceOffer(_local_12, _local_4, _local_2, _local_5, _local_10, _local_11, _local_14, _local_8, _local_13, _local_6);
                if (_local_7 < 500)
                {
                    _offers.push(_local_3);
                };
                _local_7++;
            };
            _totalItemsFound = _arg_1.readInteger();
            return (true);
        }

        public function get offers():Array
        {
            return (_offers);
        }

        public function get totalItemsFound():int
        {
            return (_totalItemsFound);
        }


    }
}


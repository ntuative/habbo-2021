package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.event.SnowWarGameEventData;

    public class GameStatusData 
    {

        private var _turn:int;
        private var _checksum:int;
        private var _events:Map;

        public function GameStatusData(_arg_1:IMessageDataWrapper)
        {
            parse(_arg_1);
        }

        public function get turn():int
        {
            return (_turn);
        }

        public function get checksum():int
        {
            return (_checksum);
        }

        public function get events():Map
        {
            return (_events);
        }

        public function parse(_arg_1:IMessageDataWrapper):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_8:Array;
            var _local_7:int;
            var _local_3:int;
            var _local_4:SnowWarGameEventData;
            _turn = _arg_1.readInteger();
            _checksum = _arg_1.readInteger();
            _events = new Map();
            var _local_2:int = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_2)
            {
                _local_6 = _arg_1.readInteger();
                _local_8 = [];
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_3 = _arg_1.readInteger();
                    _local_4 = SnowWarGameEventData.create(_local_3);
                    if (_local_4)
                    {
                        _local_4.parse(_arg_1);
                        _local_8.push(_local_4);
                    };
                    _local_7++;
                };
                _events.add(_local_5, _local_8);
                _local_5++;
            };
        }


    }
}
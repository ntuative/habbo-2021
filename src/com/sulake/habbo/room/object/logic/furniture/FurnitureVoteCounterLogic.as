package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.data.VoteResultStuffData;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.utils.getTimer;

    public class FurnitureVoteCounterLogic extends FurnitureMultiStateLogic 
    {

        private static const UPDATE_INTERVAL:int = 33;
        private static const MAX_UPDATE_TIME:int = 1000;

        private var _SafeStr_3206:int = 0;
        private var _lastUpdate:int = 0;
        private var _SafeStr_3200:int = 33;


        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:VoteResultStuffData;
            super.processUpdateMessage(_arg_1);
            var _local_3:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_3 != null)
            {
                _local_2 = (_local_3.data as VoteResultStuffData);
                if (_local_2 != null)
                {
                    updateTotal(_local_2.result);
                };
            };
        }

        private function get currentTotal():int
        {
            return (object.getModelController().getNumber("furniture_vote_counter_count"));
        }

        private function updateTotal(_arg_1:int):void
        {
            var _local_2:int;
            _SafeStr_3206 = _arg_1;
            if (_lastUpdate == 0)
            {
                object.getModelController().setNumber("furniture_vote_counter_count", _arg_1);
                _lastUpdate = getTimer();
                return;
            };
            if (_SafeStr_3206 != currentTotal)
            {
                _local_2 = Math.abs((_SafeStr_3206 - currentTotal));
                if ((_local_2 * 33) > 1000)
                {
                    _SafeStr_3200 = (1000 / _local_2);
                }
                else
                {
                    _SafeStr_3200 = 33;
                };
                _lastUpdate = getTimer();
            };
        }

        override public function update(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            super.update(_arg_1);
            if (object != null)
            {
                if (((!(currentTotal == _SafeStr_3206)) && (_arg_1 >= (_lastUpdate + _SafeStr_3200))))
                {
                    _local_2 = (_arg_1 - _lastUpdate);
                    _local_3 = int((_local_2 / _SafeStr_3200));
                    _local_4 = 1;
                    if (_SafeStr_3206 < currentTotal)
                    {
                        _local_4 = -1;
                    };
                    if (_local_3 > (_local_4 * (_SafeStr_3206 - currentTotal)))
                    {
                        _local_3 = (_local_4 * (_SafeStr_3206 - currentTotal));
                    };
                    object.getModelController().setNumber("furniture_vote_counter_count", (currentTotal + (_local_4 * _local_3)));
                    _lastUpdate = (_arg_1 - (_local_2 - (_local_3 * _SafeStr_3200)));
                };
            };
        }


    }
}


package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.utils.getTimer;

    public class FurnitureScoreBoardLogic extends FurnitureLogic 
    {

        private static const UPDATE_INTERVAL:int = 50;
        private static const MAX_UPDATE_TIME:int = 3000;

        private var _SafeStr_3199:int = 0;
        private var _lastUpdate:int = 0;
        private var _SafeStr_3200:int = 50;


        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null)
            {
                updateScore(_local_2.state);
                return;
            };
            super.processUpdateMessage(_arg_1);
        }

        private function updateScore(_arg_1:int):void
        {
            var _local_3:int;
            _SafeStr_3199 = _arg_1;
            var _local_2:int = object.getState(0);
            if (_SafeStr_3199 != _local_2)
            {
                _local_3 = (_SafeStr_3199 - _local_2);
                if (_local_3 < 0)
                {
                    _local_3 = -(_local_3);
                };
                if ((_local_3 * 50) > 3000)
                {
                    _SafeStr_3200 = (3000 / _local_3);
                }
                else
                {
                    _SafeStr_3200 = 50;
                };
                _lastUpdate = getTimer();
            };
        }

        override public function update(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            super.update(_arg_1);
            if (object != null)
            {
                _local_2 = object.getState(0);
                if (((!(_local_2 == _SafeStr_3199)) && (_arg_1 >= (_lastUpdate + _SafeStr_3200))))
                {
                    _local_3 = (_arg_1 - _lastUpdate);
                    _local_4 = int((_local_3 / _SafeStr_3200));
                    _local_5 = 1;
                    if (_SafeStr_3199 < _local_2)
                    {
                        _local_5 = -1;
                    };
                    if (_local_4 > (_local_5 * (_SafeStr_3199 - _local_2)))
                    {
                        _local_4 = (_local_5 * (_SafeStr_3199 - _local_2));
                    };
                    object.setState((_local_2 + (_local_5 * _local_4)), 0);
                    _lastUpdate = (_arg_1 - (_local_3 - (_local_4 * _SafeStr_3200)));
                };
            };
        }


    }
}


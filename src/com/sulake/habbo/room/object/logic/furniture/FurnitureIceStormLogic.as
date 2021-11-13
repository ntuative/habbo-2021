package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.data.LegacyStuffData;

    public class FurnitureIceStormLogic extends FurnitureMultiStateLogic
    {

        private var _SafeStr_3187:int = 0;
        private var _SafeStr_3188:Number = 0;
        private var _SafeStr_3189:int = 0;


        override public function processUpdateMessage(_arg_1:RoomObjectUpdateMessage):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:RoomObjectDataUpdateMessage = (_arg_1 as RoomObjectDataUpdateMessage);
            if (_local_2 != null)
            {
                handleDataUpdateMessage(_local_2);
                return;
            };
            super.processUpdateMessage(_arg_1);
        }

        private function handleDataUpdateMessage(_arg_1:RoomObjectDataUpdateMessage):void
        {
            var _local_3:LegacyStuffData;
            var _local_4:int = int((_arg_1.state / 1000));
            var _local_2:int = (_arg_1.state % 1000);
            if (_local_2 == 0)
            {
                _SafeStr_3189 = 0;
                _local_3 = new LegacyStuffData();
                _local_3.setString(String(_local_4));
                _arg_1 = new RoomObjectDataUpdateMessage(_local_4, _local_3, _arg_1.extra);
                super.processUpdateMessage(_arg_1);
            }
            else
            {
                _SafeStr_3187 = _local_4;
                _SafeStr_3188 = _arg_1.extra;
                _SafeStr_3189 = (lastUpdateTime + _local_2);
            };
        }

        override public function update(_arg_1:int):void
        {
            var _local_2:LegacyStuffData;
            var _local_3:RoomObjectDataUpdateMessage;
            if (((_SafeStr_3189 > 0) && (_arg_1 >= _SafeStr_3189)))
            {
                _SafeStr_3189 = 0;
                _local_2 = new LegacyStuffData();
                _local_2.setString(String(_SafeStr_3187));
                _local_3 = new RoomObjectDataUpdateMessage(_SafeStr_3187, _local_2, _SafeStr_3188);
                super.processUpdateMessage(_local_3);
            };
            super.update(_arg_1);
        }


    }
}
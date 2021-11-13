package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomChatSettings;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomModerationSettings;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomSettingsDataMessageParser implements IMessageParser 
    {

        private var _data:RoomSettingsData;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _data = new RoomSettingsData();
            _data.roomId = _arg_1.readInteger();
            _data.name = _arg_1.readString();
            _data.description = _arg_1.readString();
            _data.doorMode = _arg_1.readInteger();
            _data.categoryId = _arg_1.readInteger();
            _data.maximumVisitors = _arg_1.readInteger();
            _data.maximumVisitorsLimit = _arg_1.readInteger();
            _data.tags = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _data.tags.push(_arg_1.readString());
                _local_3++;
            };
            _data.tradeMode = _arg_1.readInteger();
            _data.allowPets = (_arg_1.readInteger() == 1);
            _data.allowFoodConsume = (_arg_1.readInteger() == 1);
            _data.allowWalkThrough = (_arg_1.readInteger() == 1);
            _data.hideWalls = (_arg_1.readInteger() == 1);
            _data.wallThickness = _arg_1.readInteger();
            _data.floorThickness = _arg_1.readInteger();
            _data.chatSettings = new RoomChatSettings(_arg_1);
            _data.allowNavigatorDynamicCats = _arg_1.readBoolean();
            _data.roomModerationSettings = new RoomModerationSettings(_arg_1);
            return (true);
        }

        public function flush():Boolean
        {
            _data = null;
            return (true);
        }

        public function get data():RoomSettingsData
        {
            return (_data);
        }


    }
}
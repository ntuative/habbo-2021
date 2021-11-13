package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.RoomDimmerPresetsMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomDimmerPresetsMessageParser implements IMessageParser 
    {

        private var _selectedPresetId:int = 0;
        private var _SafeStr_2081:Array = [];


        public function get presetCount():int
        {
            return (_SafeStr_2081.length);
        }

        public function get selectedPresetId():int
        {
            return (_selectedPresetId);
        }

        public function getPreset(_arg_1:int):RoomDimmerPresetsMessageData
        {
            if (((_arg_1 < 0) || (_arg_1 >= presetCount)))
            {
                return (null);
            };
            return (_SafeStr_2081[_arg_1]);
        }

        public function flush():Boolean
        {
            _SafeStr_2081 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int;
            var _local_7:int;
            var _local_9:int;
            var _local_6:String;
            var _local_2:int;
            var _local_3:int;
            var _local_8:RoomDimmerPresetsMessageData;
            var _local_4:int = _arg_1.readInteger();
            _selectedPresetId = _arg_1.readInteger();
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_7 = _arg_1.readInteger();
                _local_9 = _arg_1.readInteger();
                _local_6 = _arg_1.readString();
                _local_2 = parseInt(_local_6.substr(1), 16);
                _local_3 = _arg_1.readInteger();
                _local_8 = new RoomDimmerPresetsMessageData(_local_7);
                _local_8.type = _local_9;
                _local_8.color = _local_2;
                _local_8.light = _local_3;
                _local_8.setReadOnly();
                _SafeStr_2081.push(_local_8);
                _local_5++;
            };
            return (true);
        }


    }
}


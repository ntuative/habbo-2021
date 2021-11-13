package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomFilterSettingsMessageParser implements IMessageParser 
    {

        private var _badWords:Array;


        public function get badWords():Array
        {
            return (_badWords);
        }

        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _badWords = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _badWords.push(_arg_1.readString());
                _local_3++;
            };
            return (false);
        }


    }
}
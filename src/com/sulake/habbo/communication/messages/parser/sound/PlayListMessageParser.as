package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PlayListMessageParser implements IMessageParser 
    {

        private var _synchronizationCount:int;
        private var _playList:Array;


        public function get synchronizationCount():int
        {
            return (_synchronizationCount);
        }

        public function get playList():Array
        {
            return (_playList);
        }

        public function flush():Boolean
        {
            _synchronizationCount = -1;
            _playList = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_6:int;
            var _local_7:int;
            var _local_4:int;
            var _local_5:String;
            var _local_2:String;
            _synchronizationCount = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _local_6 = 0;
            while (_local_6 < _local_3)
            {
                _local_7 = _arg_1.readInteger();
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readString();
                _local_2 = _arg_1.readString();
                _playList.push(new PlayListEntry(_local_7, _local_4, _local_5, _local_2));
                _local_6++;
            };
            return (true);
        }


    }
}
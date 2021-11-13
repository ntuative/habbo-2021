package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TraxSongInfoMessageParser implements IMessageParser 
    {

        private var _songs:Array;


        public function get songs():Array
        {
            return (_songs);
        }

        public function flush():Boolean
        {
            _songs = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_9:int;
            var _local_4:String;
            var _local_6:String;
            var _local_2:String;
            var _local_7:int;
            var _local_3:String;
            var _local_8:int;
            var _local_10:SongInfoEntry;
            var _local_5:int = _arg_1.readInteger();
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                _local_9 = _arg_1.readInteger();
                _local_4 = _arg_1.readString();
                _local_6 = _arg_1.readString();
                _local_2 = _arg_1.readString();
                _local_7 = _arg_1.readInteger();
                _local_3 = _arg_1.readString();
                _local_10 = new SongInfoEntry(_local_9, _local_7, _local_6, _local_3, _local_2);
                _songs.push(_local_10);
                _local_8++;
            };
            return (true);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PlayListSongAddedMessageParser implements IMessageParser 
    {

        private var _entry:PlayListEntry;


        public function get entry():PlayListEntry
        {
            return (_entry);
        }

        public function flush():Boolean
        {
            _entry = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_5:int = _arg_1.readInteger();
            var _local_4:int = _arg_1.readInteger();
            var _local_2:String = _arg_1.readString();
            var _local_3:String = _arg_1.readString();
            _entry = new PlayListEntry(_local_5, _local_4, _local_2, _local_3);
            return (true);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class JukeboxSongDisksMessageParser implements IMessageParser 
    {

        private var _songDisks:Map;
        private var _maxLength:int;

        public function JukeboxSongDisksMessageParser()
        {
            _songDisks = new Map();
        }

        public function get songDisks():Map
        {
            return (_songDisks);
        }

        public function get maxLength():int
        {
            return (_maxLength);
        }

        public function flush():Boolean
        {
            _songDisks.reset();
            _maxLength = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _maxLength = _arg_1.readInteger();
            var _local_2:int = _arg_1.readInteger();
            var _local_4:int = -1;
            var _local_5:int = -1;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = _arg_1.readInteger();
                _local_5 = _arg_1.readInteger();
                _songDisks.add(_local_4, _local_5);
                _local_3++;
            };
            return (true);
        }


    }
}
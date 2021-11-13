package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NowPlayingMessageParser implements IMessageParser 
    {

        private var _currentSongId:int;
        private var _currentPosition:int;
        private var _nextSongId:int;
        private var _nextPosition:int;
        private var _syncCount:int;


        public function get currentSongId():int
        {
            return (_currentSongId);
        }

        public function get currentPosition():int
        {
            return (_currentPosition);
        }

        public function get nextSongId():int
        {
            return (_nextSongId);
        }

        public function get nextPosition():int
        {
            return (_nextPosition);
        }

        public function get syncCount():int
        {
            return (_syncCount);
        }

        public function flush():Boolean
        {
            _currentSongId = -1;
            _currentPosition = -1;
            _nextSongId = -1;
            _nextPosition = -1;
            _syncCount = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _currentSongId = _arg_1.readInteger();
            _currentPosition = _arg_1.readInteger();
            _nextSongId = _arg_1.readInteger();
            _nextPosition = _arg_1.readInteger();
            _syncCount = _arg_1.readInteger();
            return (true);
        }


    }
}
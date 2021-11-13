package com.sulake.habbo.communication.messages.parser.room.session
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YouArePlayingGameMessageParser implements IMessageParser 
    {

        private var _isPlaying:Boolean = false;


        public function get isPlaying():Boolean
        {
            return (_isPlaying);
        }

        public function flush():Boolean
        {
            _isPlaying = false;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _isPlaying = _arg_1.readBoolean();
            return (true);
        }


    }
}
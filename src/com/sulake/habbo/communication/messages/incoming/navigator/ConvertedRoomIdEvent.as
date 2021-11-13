package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdMessageParser;

        public class ConvertedRoomIdEvent extends MessageEvent 
    {

        public function ConvertedRoomIdEvent(_arg_1:Function)
        {
            super(_arg_1, ConvertedRoomIdMessageParser);
        }

        public function get globalId():String
        {
            return ((this._SafeStr_816 as ConvertedRoomIdMessageParser).globalId);
        }

        public function get convertedId():int
        {
            return ((this._SafeStr_816 as ConvertedRoomIdMessageParser).convertedId);
        }

        public function getParser():ConvertedRoomIdMessageParser
        {
            return (_SafeStr_816 as ConvertedRoomIdMessageParser);
        }


    }
}


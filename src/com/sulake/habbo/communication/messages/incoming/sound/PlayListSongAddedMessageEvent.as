package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;

        public class PlayListSongAddedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListSongAddedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PlayListSongAddedMessageParser);
        }

        public function getParser():PlayListSongAddedMessageParser
        {
            return (this._SafeStr_816 as PlayListSongAddedMessageParser);
        }


    }
}


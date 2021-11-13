package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;

        public class NowPlayingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NowPlayingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NowPlayingMessageParser);
        }

        public function getParser():NowPlayingMessageParser
        {
            return (this._SafeStr_816 as NowPlayingMessageParser);
        }


    }
}


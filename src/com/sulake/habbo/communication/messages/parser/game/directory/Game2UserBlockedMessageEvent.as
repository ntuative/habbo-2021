package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2UserBlockedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2UserBlockedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2UserBlockedMessageParser);
        }

        public function getParser():Game2UserBlockedMessageParser
        {
            return (this._SafeStr_816 as Game2UserBlockedMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2UserLeftGameMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2UserLeftGameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2UserLeftGameMessageParser);
        }

        public function getParser():Game2UserLeftGameMessageParser
        {
            return (this._SafeStr_816 as Game2UserLeftGameMessageParser);
        }


    }
}


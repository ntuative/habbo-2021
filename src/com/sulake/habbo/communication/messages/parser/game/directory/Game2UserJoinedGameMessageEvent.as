package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2UserJoinedGameMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2UserJoinedGameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2UserJoinedGameMessageParser);
        }

        public function getParser():Game2UserJoinedGameMessageParser
        {
            return (this._SafeStr_816 as Game2UserJoinedGameMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameStartedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameStartedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameStartedMessageParser);
        }

        public function getParser():Game2GameStartedMessageParser
        {
            return (this._SafeStr_816 as Game2GameStartedMessageParser);
        }


    }
}


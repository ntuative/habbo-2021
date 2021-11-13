package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2GameNotFoundMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameNotFoundMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameNotFoundMessageParser);
        }

        public function getParser():Game2GameNotFoundMessageParser
        {
            return (this._SafeStr_816 as Game2GameNotFoundMessageParser);
        }


    }
}


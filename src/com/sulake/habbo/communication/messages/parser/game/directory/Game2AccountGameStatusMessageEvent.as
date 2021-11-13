package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2AccountGameStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2AccountGameStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2AccountGameStatusMessageParser);
        }

        public function getParser():Game2AccountGameStatusMessageParser
        {
            return (this._SafeStr_816 as Game2AccountGameStatusMessageParser);
        }


    }
}


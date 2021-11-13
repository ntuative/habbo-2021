package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2StartCounterMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StartCounterMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StartCounterMessageParser);
        }

        public function getParser():Game2StartCounterMessageParser
        {
            return (this._SafeStr_816 as Game2StartCounterMessageParser);
        }


    }
}


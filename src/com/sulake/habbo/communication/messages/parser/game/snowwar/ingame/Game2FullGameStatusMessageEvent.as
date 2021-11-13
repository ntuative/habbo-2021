package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2FullGameStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2FullGameStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2FullGameStatusMessageParser);
        }

        public function getParser():Game2FullGameStatusMessageParser
        {
            return (this._SafeStr_816 as Game2FullGameStatusMessageParser);
        }


    }
}


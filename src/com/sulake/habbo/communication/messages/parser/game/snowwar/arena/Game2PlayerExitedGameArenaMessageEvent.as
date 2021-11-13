package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2PlayerExitedGameArenaMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2PlayerExitedGameArenaMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2PlayerExitedGameArenaMessageParser);
        }

        public function getParser():Game2PlayerExitedGameArenaMessageParser
        {
            return (this._SafeStr_816 as Game2PlayerExitedGameArenaMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2EnterArenaMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2EnterArenaMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2EnterArenaMessageParser);
        }

        public function getParser():Game2EnterArenaMessageParser
        {
            return (this._SafeStr_816 as Game2EnterArenaMessageParser);
        }


    }
}


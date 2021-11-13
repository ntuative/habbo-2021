package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2EnterArenaFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2EnterArenaFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2EnterArenaFailedMessageParser);
        }

        public function getParser():Game2EnterArenaFailedMessageParser
        {
            return (this._SafeStr_816 as Game2EnterArenaFailedMessageParser);
        }


    }
}


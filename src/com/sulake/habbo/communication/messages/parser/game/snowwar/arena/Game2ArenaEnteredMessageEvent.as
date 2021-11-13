package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2ArenaEnteredMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2ArenaEnteredMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2ArenaEnteredMessageParser);
        }

        public function getParser():Game2ArenaEnteredMessageParser
        {
            return (this._SafeStr_816 as Game2ArenaEnteredMessageParser);
        }


    }
}


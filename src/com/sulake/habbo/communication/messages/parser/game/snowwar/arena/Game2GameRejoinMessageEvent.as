package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameRejoinMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameRejoinMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameRejoinMessageParser);
        }

        public function getParser():Game2GameRejoinMessageParser
        {
            return (this._SafeStr_816 as Game2GameRejoinMessageParser);
        }


    }
}


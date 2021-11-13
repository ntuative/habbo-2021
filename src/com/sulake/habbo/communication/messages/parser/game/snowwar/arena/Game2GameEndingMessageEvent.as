package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameEndingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameEndingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameEndingMessageParser);
        }

        public function getParser():Game2GameEndingMessageParser
        {
            return (this._SafeStr_816 as Game2GameEndingMessageParser);
        }


    }
}


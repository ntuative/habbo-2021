package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2StageEndingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StageEndingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StageEndingMessageParser);
        }

        public function getParser():Game2StageEndingMessageParser
        {
            return (this._SafeStr_816 as Game2StageEndingMessageParser);
        }


    }
}


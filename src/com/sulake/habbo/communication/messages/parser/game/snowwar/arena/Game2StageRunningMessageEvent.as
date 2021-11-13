package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2StageRunningMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StageRunningMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StageRunningMessageParser);
        }

        public function getParser():Game2StageRunningMessageParser
        {
            return (this._SafeStr_816 as Game2StageRunningMessageParser);
        }


    }
}


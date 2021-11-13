package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2StageStillLoadingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StageStillLoadingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StageStillLoadingMessageParser);
        }

        public function getParser():Game2StageStillLoadingMessageParser
        {
            return (this._SafeStr_816 as Game2StageStillLoadingMessageParser);
        }


    }
}


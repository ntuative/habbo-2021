package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2StopCounterMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StopCounterMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StopCounterMessageParser);
        }

        public function getParser():Game2InArenaQueueMessageParser
        {
            return (this._SafeStr_816 as Game2InArenaQueueMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2GameCancelledMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameCancelledMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameCancelledMessageParser);
        }

        public function getParser():Game2GameCancelledMessageParser
        {
            return (this._SafeStr_816 as Game2GameCancelledMessageParser);
        }


    }
}


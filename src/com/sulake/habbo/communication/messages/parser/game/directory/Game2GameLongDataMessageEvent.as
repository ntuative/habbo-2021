package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameLongDataMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameLongDataMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameLongDataMessageParser);
        }

        public function getParser():Game2GameLongDataMessageParser
        {
            return (this._SafeStr_816 as Game2GameLongDataMessageParser);
        }


    }
}


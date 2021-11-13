package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameCreatedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameCreatedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameCreatedMessageParser);
        }

        public function getParser():Game2GameCreatedMessageParser
        {
            return (this._SafeStr_816 as Game2GameCreatedMessageParser);
        }


    }
}


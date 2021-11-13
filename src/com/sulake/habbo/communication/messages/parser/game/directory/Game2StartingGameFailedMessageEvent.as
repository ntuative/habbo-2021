package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2StartingGameFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2StartingGameFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2StartingGameFailedMessageParser);
        }

        public function getParser():Game2StartingGameFailedMessageParser
        {
            return (this._SafeStr_816 as Game2StartingGameFailedMessageParser);
        }


    }
}


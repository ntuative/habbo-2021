package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2JoiningGameFailedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2JoiningGameFailedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2JoiningGameFailedMessageParser);
        }

        public function getParser():Game2JoiningGameFailedMessageParser
        {
            return (this._SafeStr_816 as Game2JoiningGameFailedMessageParser);
        }


    }
}


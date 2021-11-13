package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameChatFromPlayerMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameChatFromPlayerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameChatFromPlayerMessageParser);
        }

        public function getParser():Game2GameChatFromPlayerMessageParser
        {
            return (this._SafeStr_816 as Game2GameChatFromPlayerMessageParser);
        }


    }
}


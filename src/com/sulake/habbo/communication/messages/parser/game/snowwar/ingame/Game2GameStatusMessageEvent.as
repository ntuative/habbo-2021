package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2GameStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameStatusMessageParser);
        }

        public function getParser():Game2GameStatusMessageParser
        {
            return (this._SafeStr_816 as Game2GameStatusMessageParser);
        }


    }
}


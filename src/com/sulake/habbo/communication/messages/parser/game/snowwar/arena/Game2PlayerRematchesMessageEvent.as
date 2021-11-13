package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class Game2PlayerRematchesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2PlayerRematchesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2PlayerRematchesMessageParser);
        }

        public function getParser():Game2PlayerRematchesMessageParser
        {
            return (this._SafeStr_816 as Game2PlayerRematchesMessageParser);
        }


    }
}


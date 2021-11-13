package com.sulake.habbo.communication.messages.parser.game.directory
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class Game2GameDirectoryStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function Game2GameDirectoryStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, Game2GameDirectoryStatusMessageParser);
        }

        public function getParser():Game2GameDirectoryStatusMessageParser
        {
            return (this._SafeStr_816 as Game2GameDirectoryStatusMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;

        public class PlayListMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PlayListMessageParser);
        }

        public function getParser():PlayListMessageParser
        {
            return (this._SafeStr_816 as PlayListMessageParser);
        }


    }
}


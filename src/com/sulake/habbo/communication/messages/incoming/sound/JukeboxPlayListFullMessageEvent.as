package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxPlayListFullMessageParser;

        public class JukeboxPlayListFullMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxPlayListFullMessageEvent(_arg_1:Function)
        {
            super(_arg_1, JukeboxPlayListFullMessageParser);
        }

        public function getParser():JukeboxPlayListFullMessageParser
        {
            return (this._SafeStr_816 as JukeboxPlayListFullMessageParser);
        }


    }
}


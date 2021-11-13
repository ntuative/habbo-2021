package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;

        public class JukeboxSongDisksMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxSongDisksMessageEvent(_arg_1:Function)
        {
            super(_arg_1, JukeboxSongDisksMessageParser);
        }

        public function getParser():JukeboxSongDisksMessageParser
        {
            return (this._SafeStr_816 as JukeboxSongDisksMessageParser);
        }


    }
}


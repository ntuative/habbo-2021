package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.NoSuchFlatMessageParser;

        public class NoSuchFlatEvent extends MessageEvent implements IMessageEvent 
    {

        public function NoSuchFlatEvent(_arg_1:Function)
        {
            super(_arg_1, NoSuchFlatMessageParser);
        }

        public function getParser():NoSuchFlatMessageParser
        {
            return (this._SafeStr_816 as NoSuchFlatMessageParser);
        }


    }
}


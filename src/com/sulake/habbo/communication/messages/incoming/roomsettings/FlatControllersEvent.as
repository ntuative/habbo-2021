package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllersMessageParser;

        public class FlatControllersEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllersEvent(_arg_1:Function)
        {
            super(_arg_1, FlatControllersMessageParser);
        }

        public function getParser():FlatControllersMessageParser
        {
            return (this._SafeStr_816 as FlatControllersMessageParser);
        }


    }
}


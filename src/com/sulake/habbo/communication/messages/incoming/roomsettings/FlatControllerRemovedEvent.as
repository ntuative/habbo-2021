package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;

        public class FlatControllerRemovedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatControllerRemovedEvent(_arg_1:Function)
        {
            super(_arg_1, FlatControllerRemovedMessageParser);
        }

        public function getParser():FlatControllerRemovedMessageParser
        {
            return (this._SafeStr_816 as FlatControllerRemovedMessageParser);
        }


    }
}


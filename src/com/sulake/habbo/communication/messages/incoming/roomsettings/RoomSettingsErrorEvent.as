package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;

        public class RoomSettingsErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsErrorMessageParser);
        }

        public function getParser():RoomSettingsErrorMessageParser
        {
            return (this._SafeStr_816 as RoomSettingsErrorMessageParser);
        }


    }
}


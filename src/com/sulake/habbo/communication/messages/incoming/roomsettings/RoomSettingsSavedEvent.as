package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;

        public class RoomSettingsSavedEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSavedEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsSavedMessageParser);
        }

        public function getParser():RoomSettingsSavedMessageParser
        {
            return (this._SafeStr_816 as RoomSettingsSavedMessageParser);
        }


    }
}


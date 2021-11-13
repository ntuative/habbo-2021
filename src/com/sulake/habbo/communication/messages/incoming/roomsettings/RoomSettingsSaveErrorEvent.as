package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;

        public class RoomSettingsSaveErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSaveErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsSaveErrorMessageParser);
        }

        public function getParser():RoomSettingsSaveErrorMessageParser
        {
            return (this._SafeStr_816 as RoomSettingsSaveErrorMessageParser);
        }


    }
}


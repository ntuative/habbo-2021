package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.MuteAllInRoomParser;

        public class MuteAllInRoomEvent extends MessageEvent implements IMessageEvent 
    {

        public function MuteAllInRoomEvent(_arg_1:Function)
        {
            super(_arg_1, MuteAllInRoomParser);
        }

        public function getParser():MuteAllInRoomParser
        {
            return (this._SafeStr_816 as MuteAllInRoomParser);
        }


    }
}


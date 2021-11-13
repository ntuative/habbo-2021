package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RoomMessageNotificationMessageParser;

        public class RoomMessageNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomMessageNotificationMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomMessageNotificationMessageParser);
        }

        public function getParser():RoomMessageNotificationMessageParser
        {
            return (_SafeStr_816 as RoomMessageNotificationMessageParser);
        }


    }
}


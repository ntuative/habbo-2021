package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.NotificationDialogMessageParser;

        public class NotificationDialogMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NotificationDialogMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NotificationDialogMessageParser);
        }

        public function getParser():NotificationDialogMessageParser
        {
            return (_SafeStr_816 as NotificationDialogMessageParser);
        }


    }
}


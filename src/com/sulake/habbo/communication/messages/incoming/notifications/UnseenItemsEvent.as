package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;

        public class UnseenItemsEvent extends MessageEvent implements IMessageEvent 
    {

        public function UnseenItemsEvent(_arg_1:Function)
        {
            super(_arg_1, UnseenItemsParser);
        }

        public function getParser():UnseenItemsParser
        {
            return (_SafeStr_816 as UnseenItemsParser);
        }


    }
}


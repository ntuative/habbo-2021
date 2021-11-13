package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class BadgeReceivedEvent extends MessageEvent 
    {

        public function BadgeReceivedEvent(_arg_1:Function)
        {
            super(_arg_1, BadgeReceivedParser);
        }

        public function getParser():BadgeReceivedParser
        {
            return (_SafeStr_816 as BadgeReceivedParser);
        }


    }
}


package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class BadgesEvent extends MessageEvent 
    {

        public function BadgesEvent(_arg_1:Function)
        {
            super(_arg_1, BadgesParser);
        }

        public function getParser():BadgesParser
        {
            return (_SafeStr_816 as BadgesParser);
        }


    }
}


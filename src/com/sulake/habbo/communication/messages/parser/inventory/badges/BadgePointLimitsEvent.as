package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class BadgePointLimitsEvent extends MessageEvent 
    {

        public function BadgePointLimitsEvent(_arg_1:Function)
        {
            super(_arg_1, BadgePointLimitsParser);
        }

        public function getParser():BadgePointLimitsParser
        {
            return (_SafeStr_816 as BadgePointLimitsParser);
        }


    }
}


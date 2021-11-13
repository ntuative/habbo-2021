package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class IsBadgeRequestFulfilledEvent extends MessageEvent 
    {

        public function IsBadgeRequestFulfilledEvent(_arg_1:Function)
        {
            super(_arg_1, IsBadgeRequestFulfilledParser);
        }

        public function getParser():IsBadgeRequestFulfilledParser
        {
            return (_SafeStr_816 as IsBadgeRequestFulfilledParser);
        }


    }
}


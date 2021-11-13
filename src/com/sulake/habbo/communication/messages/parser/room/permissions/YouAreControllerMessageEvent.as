package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class YouAreControllerMessageEvent extends MessageEvent 
    {

        public function YouAreControllerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreControllerMessageParser);
        }

        public function getParser():YouAreControllerMessageParser
        {
            return (_SafeStr_816 as YouAreControllerMessageParser);
        }


    }
}


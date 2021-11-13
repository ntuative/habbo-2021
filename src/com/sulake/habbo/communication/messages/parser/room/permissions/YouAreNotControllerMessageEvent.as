package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.MessageEvent;

        public class YouAreNotControllerMessageEvent extends MessageEvent 
    {

        public function YouAreNotControllerMessageEvent(_arg_1:Function)
        {
            super(_arg_1, YouAreNotControllerMessageParser);
        }

        public function getParser():YouAreNotControllerMessageParser
        {
            return (_SafeStr_816 as YouAreNotControllerMessageParser);
        }


    }
}


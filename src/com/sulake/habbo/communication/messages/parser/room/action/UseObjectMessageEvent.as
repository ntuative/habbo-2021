package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class UseObjectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UseObjectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UseObjectMessageParser);
        }

        public function getParser():UseObjectMessageParser
        {
            return (_SafeStr_816 as UseObjectMessageParser);
        }


    }
}


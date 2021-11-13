package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class CarryObjectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CarryObjectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CarryObjectMessageParser);
        }

        public function getParser():CarryObjectMessageParser
        {
            return (_SafeStr_816 as CarryObjectMessageParser);
        }


    }
}


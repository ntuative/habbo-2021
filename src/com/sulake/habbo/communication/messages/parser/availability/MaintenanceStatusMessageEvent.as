package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class MaintenanceStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function MaintenanceStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, MaintenanceStatusMessageParser);
        }

        public function getParser():MaintenanceStatusMessageParser
        {
            return (_SafeStr_816 as MaintenanceStatusMessageParser);
        }


    }
}


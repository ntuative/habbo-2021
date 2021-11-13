package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniConditionMessageParser;

        public class WiredFurniConditionEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniConditionEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniConditionMessageParser);
        }

        public function getParser():WiredFurniConditionMessageParser
        {
            return (this._SafeStr_816 as WiredFurniConditionMessageParser);
        }


    }
}


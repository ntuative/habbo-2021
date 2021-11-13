package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniTriggerMessageParser;

        public class WiredFurniTriggerEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniTriggerEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniTriggerMessageParser);
        }

        public function getParser():WiredFurniTriggerMessageParser
        {
            return (this._SafeStr_816 as WiredFurniTriggerMessageParser);
        }


    }
}


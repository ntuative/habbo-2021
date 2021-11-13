package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredFurniActionMessageParser;

        public class WiredFurniActionEvent extends MessageEvent implements IMessageEvent 
    {

        public function WiredFurniActionEvent(_arg_1:Function)
        {
            super(_arg_1, WiredFurniActionMessageParser);
        }

        public function getParser():WiredFurniActionMessageParser
        {
            return (this._SafeStr_816 as WiredFurniActionMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;

        public class FlatCreatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatCreatedEvent(_arg_1:Function)
        {
            super(_arg_1, FlatCreatedMessageParser);
        }

        public function getParser():FlatCreatedMessageParser
        {
            return (this._SafeStr_816 as FlatCreatedMessageParser);
        }


    }
}


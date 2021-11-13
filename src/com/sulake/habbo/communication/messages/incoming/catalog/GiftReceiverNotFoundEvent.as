package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog._SafeStr_61;

        public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent 
    {

        public function GiftReceiverNotFoundEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_61);
        }

        public function getParser():_SafeStr_61
        {
            return (this._SafeStr_816 as _SafeStr_61);
        }


    }
}


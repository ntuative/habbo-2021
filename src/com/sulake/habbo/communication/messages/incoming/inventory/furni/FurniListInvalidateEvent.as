package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni._SafeStr_71;

        public class FurniListInvalidateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FurniListInvalidateEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_71);
        }

        public function getParser():_SafeStr_71
        {
            return (this._SafeStr_816 as _SafeStr_71);
        }


    }
}


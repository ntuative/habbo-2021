package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help._SafeStr_72;

        public class HotelMergeNameChangeEvent extends MessageEvent implements IMessageEvent 
    {

        public function HotelMergeNameChangeEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_72);
        }

        public function getParser():_SafeStr_72
        {
            return (_SafeStr_816 as _SafeStr_72);
        }


    }
}


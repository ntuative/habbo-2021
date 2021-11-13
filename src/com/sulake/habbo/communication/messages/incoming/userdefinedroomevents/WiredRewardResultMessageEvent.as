package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredRewardResultMessageParser;

        public class WiredRewardResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_1846:int = 6;
        public static const _SafeStr_1847:int = 7;

        public function WiredRewardResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, WiredRewardResultMessageParser);
        }

        public function getParser():WiredRewardResultMessageParser
        {
            return (this._SafeStr_816 as WiredRewardResultMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser;

        public class HabboSearchResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboSearchResultEvent(_arg_1:Function)
        {
            super(_arg_1, HabboSearchResultMessageParser);
        }

        public function getParser():HabboSearchResultMessageParser
        {
            return (this._SafeStr_816 as HabboSearchResultMessageParser);
        }


    }
}


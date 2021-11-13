package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;

        public class HabboClubOffersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboClubOffersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HabboClubOffersMessageParser);
        }

        public function getParser():HabboClubOffersMessageParser
        {
            return (this._SafeStr_816 as HabboClubOffersMessageParser);
        }


    }
}


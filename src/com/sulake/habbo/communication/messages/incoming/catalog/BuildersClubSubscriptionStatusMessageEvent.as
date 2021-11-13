package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageParser;

        public class BuildersClubSubscriptionStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function BuildersClubSubscriptionStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, BuildersClubSubscriptionStatusMessageParser);
        }

        public function getParser():BuildersClubSubscriptionStatusMessageParser
        {
            return (this._SafeStr_816 as BuildersClubSubscriptionStatusMessageParser);
        }


    }
}


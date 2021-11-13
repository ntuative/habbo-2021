package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.RoomAdPurchaseInfoEventParser;

        public class RoomAdPurchaseInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomAdPurchaseInfoEvent(_arg_1:Function)
        {
            super(_arg_1, RoomAdPurchaseInfoEventParser);
        }

        public function getParser():RoomAdPurchaseInfoEventParser
        {
            return (this._SafeStr_816 as RoomAdPurchaseInfoEventParser);
        }


    }
}


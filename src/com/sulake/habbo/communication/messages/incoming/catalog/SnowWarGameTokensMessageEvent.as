package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokensMessageParser;

    public class SnowWarGameTokensMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SnowWarGameTokensMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SnowWarGameTokensMessageParser);
        }

        public function getParser():SnowWarGameTokensMessageParser
        {
            return (this._SafeStr_816 as SnowWarGameTokensMessageParser);
        }


    }
}


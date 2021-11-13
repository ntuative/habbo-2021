package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.GiftWrappingConfigurationParser;

        public class GiftWrappingConfigurationEvent extends MessageEvent implements IMessageEvent 
    {

        public function GiftWrappingConfigurationEvent(_arg_1:Function)
        {
            super(_arg_1, GiftWrappingConfigurationParser);
        }

        public function getParser():GiftWrappingConfigurationParser
        {
            return (this._SafeStr_816 as GiftWrappingConfigurationParser);
        }


    }
}


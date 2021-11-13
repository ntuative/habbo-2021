package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.BundleDiscountRulesetMessageParser;

        public class BundleDiscountRulesetMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function BundleDiscountRulesetMessageEvent(_arg_1:Function)
        {
            super(_arg_1, BundleDiscountRulesetMessageParser);
        }

        public function getParser():BundleDiscountRulesetMessageParser
        {
            return (this._SafeStr_816 as BundleDiscountRulesetMessageParser);
        }


    }
}


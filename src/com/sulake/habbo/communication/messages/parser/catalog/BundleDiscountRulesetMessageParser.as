package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRuleset;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BundleDiscountRulesetMessageParser implements IMessageParser 
    {

        private var _bundleDiscountRuleset:BundleDiscountRuleset;


        public function get bundleDiscountRuleset():BundleDiscountRuleset
        {
            return (_bundleDiscountRuleset);
        }

        public function flush():Boolean
        {
            _bundleDiscountRuleset = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _bundleDiscountRuleset = new BundleDiscountRuleset(_arg_1);
            return (true);
        }


    }
}
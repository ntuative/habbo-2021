package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemOkMessageParser;

        public class VoucherRedeemOkMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemOkMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoucherRedeemOkMessageParser);
        }

        public function get productName():String
        {
            return ((_SafeStr_816 as VoucherRedeemOkMessageParser).productName);
        }

        public function get productDescription():String
        {
            return ((_SafeStr_816 as VoucherRedeemOkMessageParser).productDescription);
        }


    }
}


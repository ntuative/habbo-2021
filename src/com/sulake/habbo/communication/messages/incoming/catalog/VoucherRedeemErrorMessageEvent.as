package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.VoucherRedeemErrorMessageParser;

        public class VoucherRedeemErrorMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function VoucherRedeemErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, VoucherRedeemErrorMessageParser);
        }

        public function get errorCode():String
        {
            return ((_SafeStr_816 as VoucherRedeemErrorMessageParser).errorCode);
        }


    }
}


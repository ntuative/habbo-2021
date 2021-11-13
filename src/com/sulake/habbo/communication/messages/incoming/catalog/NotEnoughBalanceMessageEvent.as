package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageParser;

        public class NotEnoughBalanceMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NotEnoughBalanceMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NotEnoughBalanceMessageParser);
        }

        public function getParser():NotEnoughBalanceMessageParser
        {
            return (this._SafeStr_816 as NotEnoughBalanceMessageParser);
        }


    }
}


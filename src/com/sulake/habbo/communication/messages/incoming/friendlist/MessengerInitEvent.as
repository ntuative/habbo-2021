package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;

        public class MessengerInitEvent extends MessageEvent implements IMessageEvent 
    {

        public function MessengerInitEvent(_arg_1:Function)
        {
            super(_arg_1, MessengerInitMessageParser);
        }

        public function getParser():MessengerInitMessageParser
        {
            return (this._SafeStr_816 as MessengerInitMessageParser);
        }


    }
}


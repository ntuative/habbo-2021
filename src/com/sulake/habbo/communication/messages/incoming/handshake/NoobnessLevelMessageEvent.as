package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.NoobnessLevelMessageEventMessageParser;

        public class NoobnessLevelMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NoobnessLevelMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NoobnessLevelMessageEventMessageParser);
        }

        public function get noobnessLevel():int
        {
            return ((this._SafeStr_816 as NoobnessLevelMessageEventMessageParser).noobnessLevel);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.IsFirstLoginOfDayParser;

        public class IsFirstLoginOfDayEvent extends MessageEvent implements IMessageEvent 
    {

        public function IsFirstLoginOfDayEvent(_arg_1:Function)
        {
            super(_arg_1, IsFirstLoginOfDayParser);
        }

        public function getParser():IsFirstLoginOfDayParser
        {
            return (this._SafeStr_816 as IsFirstLoginOfDayParser);
        }


    }
}


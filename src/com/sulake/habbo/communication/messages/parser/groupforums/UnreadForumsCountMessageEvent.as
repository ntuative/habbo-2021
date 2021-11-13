package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class UnreadForumsCountMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UnreadForumsCountMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UnreadForumsCountMessageParser);
        }

        public function getParser():UnreadForumsCountMessageParser
        {
            return (this._SafeStr_816 as UnreadForumsCountMessageParser);
        }


    }
}


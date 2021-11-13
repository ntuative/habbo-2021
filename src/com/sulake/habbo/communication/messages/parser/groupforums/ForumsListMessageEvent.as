package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class ForumsListMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ForumsListMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GetForumsListMessageParser);
        }

        public function getParser():GetForumsListMessageParser
        {
            return (GetForumsListMessageParser(this._SafeStr_816));
        }


    }
}


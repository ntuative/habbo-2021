package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class UpdateMessageMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UpdateMessageMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UpdateMessageMessageParser);
        }

        public function getParser():UpdateMessageMessageParser
        {
            return (this._SafeStr_816 as UpdateMessageMessageParser);
        }


    }
}


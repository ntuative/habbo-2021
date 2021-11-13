package com.sulake.habbo.communication.messages.parser.groupforums
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

        public class UpdateThreadMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UpdateThreadMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UpdateThreadMessageParser);
        }

        public function getParser():UpdateThreadMessageParser
        {
            return (this._SafeStr_816 as UpdateThreadMessageParser);
        }


    }
}


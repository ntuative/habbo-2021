package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;

        public class NewConsoleMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NewConsoleMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NewConsoleMessageMessageParser);
        }

        public function getParser():NewConsoleMessageMessageParser
        {
            return (this._SafeStr_816 as NewConsoleMessageMessageParser);
        }


    }
}


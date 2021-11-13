package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.QuestsMessageParser;

        public class QuestsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function QuestsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, QuestsMessageParser);
        }

        public function getParser():QuestsMessageParser
        {
            return (_SafeStr_816 as QuestsMessageParser);
        }


    }
}


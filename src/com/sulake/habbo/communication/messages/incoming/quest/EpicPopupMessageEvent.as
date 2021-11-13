package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.quest.EpicPopupMessageParser;

        public class EpicPopupMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function EpicPopupMessageEvent(_arg_1:Function)
        {
            super(_arg_1, EpicPopupMessageParser);
        }

        public function getParser():EpicPopupMessageParser
        {
            return (_SafeStr_816 as EpicPopupMessageParser);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionRequesterRoomMessageParser;

        public class GuideSessionRequesterRoomMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionRequesterRoomMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionRequesterRoomMessageParser);
        }

        public function getParser():GuideSessionRequesterRoomMessageParser
        {
            return (_SafeStr_816 as GuideSessionRequesterRoomMessageParser);
        }


    }
}


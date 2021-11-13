package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.GuideSessionInvitedToGuideRoomMessageParser;

        public class GuideSessionInvitedToGuideRoomMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function GuideSessionInvitedToGuideRoomMessageEvent(_arg_1:Function)
        {
            super(_arg_1, GuideSessionInvitedToGuideRoomMessageParser);
        }

    }
}
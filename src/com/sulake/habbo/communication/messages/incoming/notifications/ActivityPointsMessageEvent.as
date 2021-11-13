package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ActivityPointsMessageParser;
    import flash.utils.Dictionary;

        public class ActivityPointsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ActivityPointsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ActivityPointsMessageParser);
        }

        public function get points():Dictionary
        {
            return ((_SafeStr_816 as ActivityPointsMessageParser).points);
        }


    }
}


package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users._SafeStr_68;
    import com.sulake.core.utils.Map;

        public class HabboGroupBadgesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupBadgesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, _SafeStr_68);
        }

        public function get badges():Map
        {
            return ((_SafeStr_816 as _SafeStr_68).badges);
        }


    }
}


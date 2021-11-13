package com.sulake.habbo.groups.events
{
    import flash.events.Event;

    public class GuildSettingsChangedInManageEvent extends Event 
    {

        public static const GUILD_VISUAL_SETTINGS_CHANGED:String = "GSCIME_GUILD_VISUAL_SETTINGS_CHANGED";

        private var _guildId:int;

        public function GuildSettingsChangedInManageEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _guildId = _arg_2;
        }

        public function get guildId():int
        {
            return (_guildId);
        }


    }
}
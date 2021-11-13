package com.sulake.habbo.help.enum
{
    import flash.events.Event;

    public class HabboHelpTutorialEvent extends Event 
    {

        public static const _SafeStr_2659:String = "HHTPNUFWE_AVATAR_TUTORIAL_START";
        public static const _SafeStr_2660:String = "HHTPNUFWE_LIGHT_CLOTHES_ICON";
        public static const DONE_AVATAR_EDITOR_OPENING:String = "HHTE_DONE_AVATAR_EDITOR_OPENING";
        public static const DONE_AVATAR_EDITOR_CLOSING:String = "HHTE_DONE_AVATAR_EDITOR_CLOSING";

        public function HabboHelpTutorialEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

    }
}


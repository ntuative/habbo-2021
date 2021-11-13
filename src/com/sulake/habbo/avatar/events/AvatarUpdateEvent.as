package com.sulake.habbo.avatar.events
{
    import flash.events.Event;

    public class AvatarUpdateEvent extends Event 
    {

        public static const AVATAR_FIGURE_UPDATED:String = "AVATAR_FIGURE_UPDATED";

        private var _figure:String;

        public function AvatarUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("AVATAR_FIGURE_UPDATED", _arg_2, _arg_3);
            _figure = _arg_1;
        }

        public function get figure():String
        {
            return (_figure);
        }


    }
}
package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class UserNameUpdateEvent extends Event 
    {

        public static const NAME_UPDATE:String = "unue_name_updated";

        private var _name:String;

        public function UserNameUpdateEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super("unue_name_updated", _arg_2, _arg_3);
            _name = _arg_1;
        }

        public function get name():String
        {
            return (_name);
        }


    }
}
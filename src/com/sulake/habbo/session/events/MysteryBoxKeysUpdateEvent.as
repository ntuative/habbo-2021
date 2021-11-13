package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class MysteryBoxKeysUpdateEvent extends Event 
    {

        public static const MYSTERY_BOX_KEYS_UPDATE:String = "mbke_update";

        private var _boxColor:String;
        private var _keyColor:String;

        public function MysteryBoxKeysUpdateEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("mbke_update", _arg_3, _arg_4);
            _boxColor = _arg_1;
            _keyColor = _arg_2;
        }

        public function get boxColor():String
        {
            return (_boxColor);
        }

        public function get keyColor():String
        {
            return (_keyColor);
        }


    }
}
package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;

    public class InterstitialEvent extends Event 
    {

        public static const INTERSTITIAL_SHOW:String = "AE_INTERSTITIAL_SHOW";
        public static const INTERSTITIAL_NOT_SHOWN:String = "AE_INTERSTITIAL_NOT_SHOWN";
        public static const INTERSTITIAL_COMPLETE:String = "AE_INTERSTITIAL_COMPLETE";

        private var _status:String;

        public function InterstitialEvent(_arg_1:String, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            _status = _arg_2;
        }

        public function get status():String
        {
            return (_status);
        }


    }
}
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetSpinnerEvent extends Event 
    {

        public static const VALUE_CHANGED:String = "CWSE_VALUE_CHANGED";
        public static const RESET:String = "CWSE_RESET";
        public static const SHOW:String = "CWSE_SHOW";
        public static const HIDE:String = "CWSE_HIDE";
        public static const _SafeStr_1540:String = "CWSE_SET_MAX";
        public static const SET_MIN:String = "CWSE_SET_MIN";

        private var _value:int;
        private var _skipSteps:Array;

        public function CatalogWidgetSpinnerEvent(_arg_1:String, _arg_2:int=1, _arg_3:Array=null)
        {
            super(_arg_1);
            _value = _arg_2;
            _skipSteps = _arg_3;
        }

        public function get value():int
        {
            return (_value);
        }

        public function get skipSteps():Array
        {
            return (_skipSteps);
        }


    }
}


package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetToggleEvent extends Event 
    {

        private var _widgetId:String;
        private var _enabled:Boolean;

        public function CatalogWidgetToggleEvent(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super("CWE_TOGGLE", _arg_3, _arg_4);
            _widgetId = _arg_1;
            _enabled = _arg_2;
        }

        public function get widgetId():String
        {
            return (_widgetId);
        }

        public function get enabled():Boolean
        {
            return (_enabled);
        }


    }
}
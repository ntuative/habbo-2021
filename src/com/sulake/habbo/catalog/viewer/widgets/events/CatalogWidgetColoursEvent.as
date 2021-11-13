package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetColoursEvent extends Event 
    {

        private var _colours:Array;
        private var _backgroundAssetName:String;
        private var _colourAssetName:String;
        private var _chosenColourAssetName:String;
        private var _index:int;

        public function CatalogWidgetColoursEvent(_arg_1:Array, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super("COLOUR_ARRAY", _arg_6, _arg_7);
            _colours = _arg_1;
            _backgroundAssetName = _arg_2;
            _colourAssetName = _arg_3;
            _chosenColourAssetName = _arg_4;
            _index = _arg_5;
        }

        public function get colours():Array
        {
            return (_colours);
        }

        public function get backgroundAssetName():String
        {
            return (_backgroundAssetName);
        }

        public function get colourAssetName():String
        {
            return (_colourAssetName);
        }

        public function get chosenColourAssetName():String
        {
            return (_chosenColourAssetName);
        }

        public function get index():int
        {
            return (_index);
        }


    }
}
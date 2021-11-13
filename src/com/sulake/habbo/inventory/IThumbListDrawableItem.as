package com.sulake.habbo.inventory
{
    import flash.display.BitmapData;

    public /*dynamic*/ interface IThumbListDrawableItem 
    {

        function set iconImage(_arg_1:BitmapData):void;
        function get iconImage():BitmapData;
        function set isSelected(_arg_1:Boolean):void;
        function get isSelected():Boolean;

    }
}
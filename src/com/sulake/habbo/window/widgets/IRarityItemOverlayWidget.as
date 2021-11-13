package com.sulake.habbo.window.widgets
{
    import com.sulake.core.window.IWidget;

    public /*dynamic*/ interface IRarityItemOverlayWidget extends IWidget 
    {

        function set rarityLevel(_arg_1:int):void;
        function get rarityLevel():int;

    }
}
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IMeMenuView 
    {

        function init(_arg_1:MeMenuWidget, _arg_2:String):void;
        function dispose():void;
        function get window():IWindowContainer;
        function updateUnseenItemCount(_arg_1:String, _arg_2:int):void;

    }
}
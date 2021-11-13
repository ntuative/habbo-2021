package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface ICatalogWidget 
    {

        function set page(_arg_1:ICatalogPage):void;
        function set events(_arg_1:IEventDispatcher):void;
        function get window():IWindowContainer;
        function get events():IEventDispatcher;
        function get page():ICatalogPage;
        function dispose():void;
        function init():Boolean;
        function closed():void;

    }
}
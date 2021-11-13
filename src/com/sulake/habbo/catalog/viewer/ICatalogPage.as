package com.sulake.habbo.catalog.viewer
{
    import flash.events.Event;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public /*dynamic*/ interface ICatalogPage 
    {

        function dispose():void;
        function init():void;
        function closed():void;
        function dispatchWidgetEvent(_arg_1:Event):Boolean;
        function get window():IWindowContainer;
        function get viewer():ICatalogViewer;
        function get pageId():int;
        function get offers():Vector.<IPurchasableOffer>;
        function get localization():IPageLocalization;
        function get layoutCode():String;
        function get hasLinks():Boolean;
        function get links():Array;
        function selectOffer(_arg_1:int):void;
        function replaceOffers(_arg_1:Vector.<IPurchasableOffer>, _arg_2:Boolean=false):void;
        function updateLimitedItemsLeft(_arg_1:int, _arg_2:int):void;
        function get acceptSeasonCurrencyAsCredits():Boolean;
        function get allowDragging():Boolean;
        function set searchPageId(_arg_1:int):void;
        function get mode():int;
        function get isBuilderPage():Boolean;

    }
}
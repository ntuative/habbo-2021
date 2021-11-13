package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.room.IStuffData;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public /*dynamic*/ interface IProductContainer extends IDisposable 
    {

        function initProductIcon(_arg_1:IRoomEngine, _arg_2:IStuffData=null):void;
        function activate():void;
        function get products():Vector.<IProduct>;
        function get firstProduct():IProduct;
        function set view(_arg_1:IWindowContainer):void;
        function get view():IWindowContainer;
        function set grid(_arg_1:IItemGrid):void;
        function setClubIconLevel(_arg_1:int):void;
        function get offer():IPurchasableOffer;

    }
}
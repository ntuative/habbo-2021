package com.sulake.core.window.graphics
{
    import flash.display.IBitmapDrawable;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;

    public /*dynamic*/ interface IGraphicContext extends IBitmapDrawable, IEventDispatcher, IDisposable 
    {

        function get parent():DisplayObjectContainer;
        function set parent(_arg_1:DisplayObjectContainer):void;
        function get filters():Array;
        function set filters(_arg_1:Array):void;
        function get visible():Boolean;
        function set visible(_arg_1:Boolean):void;
        function get blend():Number;
        function set blend(_arg_1:Number):void;
        function get mouse():Boolean;
        function set mouse(_arg_1:Boolean):void;
        function offSet(_arg_1:Point):void;
        function getDrawRegion():Rectangle;
        function setDrawRegion(_arg_1:Rectangle, _arg_2:Boolean, _arg_3:Rectangle):BitmapData;
        function getDisplayObject():DisplayObject;
        function setDisplayObject(_arg_1:DisplayObject):DisplayObject;
        function getAbsoluteMousePosition(_arg_1:Point):void;
        function getRelativeMousePosition(_arg_1:Point):void;
        function fetchDrawBuffer():IBitmapDrawable;
        function showRedrawRegion(_arg_1:Rectangle):void;
        function get numChildContexts():int;
        function addChildContext(_arg_1:IGraphicContext):IGraphicContext;
        function addChildContextAt(_arg_1:IGraphicContext, _arg_2:int):IGraphicContext;
        function getChildContextAt(_arg_1:int):IGraphicContext;
        function getChildContextIndex(_arg_1:IGraphicContext):int;
        function removeChildContext(_arg_1:IGraphicContext):IGraphicContext;
        function removeChildContextAt(_arg_1:int):IGraphicContext;
        function setChildContextIndex(_arg_1:IGraphicContext, _arg_2:int):void;
        function swapChildContexts(_arg_1:IGraphicContext, _arg_2:IGraphicContext):void;
        function swapChildContextsAt(_arg_1:int, _arg_2:int):void;

    }
}
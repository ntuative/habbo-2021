package com.sulake.core.window.graphics
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContext;
    import flash.display.BitmapData;

    public /*dynamic*/ interface IWindowRenderer extends IDisposable 
    {

        function set debug(_arg_1:Boolean):void;
        function render():void;
        function addToRenderQueue(_arg_1:IWindow, _arg_2:Rectangle, _arg_3:uint):void;
        function flushRenderQueue():void;
        function invalidate(_arg_1:IWindowContext, _arg_2:Rectangle):void;
        function getDrawBufferForRenderable(_arg_1:IWindow):BitmapData;
        function purge(_arg_1:IWindow=null, _arg_2:Boolean=true):void;

    }
}
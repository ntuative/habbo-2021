package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public /*dynamic*/ interface ISkinRenderer extends IDisposable 
    {

        function get name():String;
        function parse(_arg_1:IAsset, _arg_2:XMLList, _arg_3:IAssetLibrary):void;
        function draw(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:Rectangle, _arg_4:uint, _arg_5:Boolean):void;
        function isStateDrawable(_arg_1:uint):Boolean;
        function addLayout(_arg_1:ISkinLayout):ISkinLayout;
        function getLayoutByName(_arg_1:String):ISkinLayout;
        function removeLayout(_arg_1:ISkinLayout):ISkinLayout;
        function getLayoutByState(_arg_1:uint):ISkinLayout;
        function registerLayoutForRenderState(_arg_1:uint, _arg_2:String):void;
        function removeLayoutFromRenderState(_arg_1:uint):void;
        function hasLayoutForState(_arg_1:uint):Boolean;
        function addTemplate(_arg_1:ISkinTemplate):ISkinTemplate;
        function getTemplateByName(_arg_1:String):ISkinTemplate;
        function removeTemplate(_arg_1:ISkinTemplate):ISkinTemplate;
        function getTemplateByState(_arg_1:uint):ISkinTemplate;
        function registerTemplateForRenderState(_arg_1:uint, _arg_2:String):void;
        function removeTemplateFromRenderState(_arg_1:uint):void;
        function hasTemplateForState(_arg_1:uint):Boolean;

    }
}
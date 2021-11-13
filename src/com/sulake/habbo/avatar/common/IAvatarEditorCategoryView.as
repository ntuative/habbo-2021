package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface IAvatarEditorCategoryView 
    {

        function dispose():void;
        function init():void;
        function reset():void;
        function getWindowContainer():IWindowContainer;
        function switchCategory(_arg_1:String):void;
        function showPalettes(_arg_1:String, _arg_2:int):void;

    }
}
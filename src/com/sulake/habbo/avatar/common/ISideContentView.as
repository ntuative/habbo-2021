package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;

    public /*dynamic*/ interface ISideContentView 
    {

        function dispose():void;
        function getWindowContainer():IWindowContainer;

    }
}
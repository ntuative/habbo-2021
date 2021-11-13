package com.sulake.habbo.freeflowchat.style
{
    public /*dynamic*/ interface IChatStyleLibrary 
    {

        function getStyleIds():Array;
        function getStyle(_arg_1:int):IChatStyle;

    }
}
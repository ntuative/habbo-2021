package com.sulake.core.assets
{
    public /*dynamic*/ interface ILazyAsset extends IAsset 
    {

        function prepareLazyContent():void;

    }
}
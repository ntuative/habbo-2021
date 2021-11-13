package com.sulake.habbo.session.furniture
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface IFurniDataListener extends IDisposable 
    {

        function furniDataReady():void;

    }
}
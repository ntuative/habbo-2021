package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.core.runtime.IDisposable;

    public /*dynamic*/ interface ICollidable extends IDisposable 
    {

        function get boundingType():int;
        function get boundingData():Array;
        function get location3D():Location3D;
        function get direction360():Direction360;

    }
}
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import flash.geom.Point;
    import flash.display.BitmapData;

    public /*dynamic*/ interface AnimationObject extends IDisposable 
    {

        function getPosition(_arg_1:int):Point;
        function getBitmap(_arg_1:int):BitmapData;
        function isFinished(_arg_1:int):Boolean;
        function onAnimationStart():void;

    }
}
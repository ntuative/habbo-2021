package com.codeazur.as3swf.exporters.core
{
    import flash.geom.Matrix;

    public /*dynamic*/ interface IShapeExporter 
    {

        function beginShape():void;
        function endShape():void;
        function beginFills():void;
        function endFills():void;
        function beginLines():void;
        function endLines():void;
        function beginFill(_arg_1:uint, _arg_2:Number=1):void;
        function beginGradientFill(_arg_1:String, _arg_2:Array, _arg_3:Array, _arg_4:Array, _arg_5:Matrix=null, _arg_6:String="pad", _arg_7:String="rgb", _arg_8:Number=0):void;
        function beginBitmapFill(_arg_1:uint, _arg_2:Matrix=null, _arg_3:Boolean=true, _arg_4:Boolean=false):void;
        function endFill():void;
        function lineStyle(_arg_1:Number=NaN, _arg_2:uint=0, _arg_3:Number=1, _arg_4:Boolean=false, _arg_5:String="normal", _arg_6:String=null, _arg_7:String=null, _arg_8:String=null, _arg_9:Number=3):void;
        function lineGradientStyle(_arg_1:String, _arg_2:Array, _arg_3:Array, _arg_4:Array, _arg_5:Matrix=null, _arg_6:String="pad", _arg_7:String="rgb", _arg_8:Number=0):void;
        function moveTo(_arg_1:Number, _arg_2:Number):void;
        function lineTo(_arg_1:Number, _arg_2:Number):void;
        function curveTo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void;

    }
}
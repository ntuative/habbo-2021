package com.codeazur.as3swf.exporters.core
{
    import com.codeazur.as3swf.SWF;
    import flash.geom.Matrix;

    public class DefaultShapeExporter implements IShapeExporter 
    {

        protected var swf:SWF;

        public function DefaultShapeExporter(_arg_1:SWF)
        {
            this.swf = _arg_1;
        }

        public function beginShape():void
        {
        }

        public function endShape():void
        {
        }

        public function beginFills():void
        {
        }

        public function endFills():void
        {
        }

        public function beginLines():void
        {
        }

        public function endLines():void
        {
        }

        public function beginFill(_arg_1:uint, _arg_2:Number=1):void
        {
        }

        public function beginGradientFill(_arg_1:String, _arg_2:Array, _arg_3:Array, _arg_4:Array, _arg_5:Matrix=null, _arg_6:String="pad", _arg_7:String="rgb", _arg_8:Number=0):void
        {
        }

        public function beginBitmapFill(_arg_1:uint, _arg_2:Matrix=null, _arg_3:Boolean=true, _arg_4:Boolean=false):void
        {
        }

        public function endFill():void
        {
        }

        public function lineStyle(_arg_1:Number=NaN, _arg_2:uint=0, _arg_3:Number=1, _arg_4:Boolean=false, _arg_5:String="normal", _arg_6:String=null, _arg_7:String=null, _arg_8:String=null, _arg_9:Number=3):void
        {
        }

        public function lineGradientStyle(_arg_1:String, _arg_2:Array, _arg_3:Array, _arg_4:Array, _arg_5:Matrix=null, _arg_6:String="pad", _arg_7:String="rgb", _arg_8:Number=0):void
        {
        }

        public function moveTo(_arg_1:Number, _arg_2:Number):void
        {
        }

        public function lineTo(_arg_1:Number, _arg_2:Number):void
        {
        }

        public function curveTo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
        }


    }
}
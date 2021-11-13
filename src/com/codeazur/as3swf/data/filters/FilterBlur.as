package com.codeazur.as3swf.data.filters
{
    import flash.filters.BlurFilter;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;

    public class FilterBlur extends Filter implements IFilter 
    {

        public var blurX:Number;
        public var blurY:Number;
        public var _SafeStr_397:uint;

        public function FilterBlur(_arg_1:uint)
        {
            super(_arg_1);
        }

        override public function get filter():BitmapFilter
        {
            return (new BlurFilter(blurX, blurY, _SafeStr_397));
        }

        override public function parse(_arg_1:SWFData):void
        {
            blurX = _arg_1.readFIXED();
            blurY = _arg_1.readFIXED();
            _SafeStr_397 = (_arg_1.readUI8() >> 3);
        }

        override public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeFIXED(blurX);
            _arg_1.writeFIXED(blurY);
            _arg_1.writeUI8((_SafeStr_397 << 3));
        }

        override public function clone():IFilter
        {
            var _local_1:FilterBlur = new FilterBlur(id);
            _local_1.blurX = blurX;
            _local_1.blurY = blurY;
            _local_1._SafeStr_397 = _SafeStr_397;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((((((("[BlurFilter] BlurX: " + blurX) + ", ") + "BlurY: ") + blurY) + ", ") + "Passes: ") + _SafeStr_397);
        }


    }
}


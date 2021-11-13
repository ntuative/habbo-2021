package com.codeazur.as3swf.data.filters
{
    import __AS3__.vec.Vector;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.BitmapFilter;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class FilterColorMatrix extends Filter implements IFilter 
    {

        protected var _SafeStr_699:Vector.<Number>;

        public function FilterColorMatrix(_arg_1:uint)
        {
            super(_arg_1);
            _SafeStr_699 = new Vector.<Number>();
        }

        public function get colorMatrix():Vector.<Number>
        {
            return (_SafeStr_699);
        }

        override public function get filter():BitmapFilter
        {
            return (new ColorMatrixFilter([colorMatrix[0], colorMatrix[1], colorMatrix[2], colorMatrix[3], colorMatrix[4], colorMatrix[5], colorMatrix[6], colorMatrix[7], colorMatrix[8], colorMatrix[9], colorMatrix[10], colorMatrix[11], colorMatrix[12], colorMatrix[13], colorMatrix[14], colorMatrix[15], colorMatrix[16], colorMatrix[17], colorMatrix[18], colorMatrix[19]]));
        }

        override public function parse(_arg_1:SWFData):void
        {
            var _local_2:uint;
            _local_2 = 0;
            while (_local_2 < 20)
            {
                colorMatrix.push(_arg_1.readFLOAT());
                _local_2++;
            };
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:uint;
            _local_2 = 0;
            while (_local_2 < 20)
            {
                _arg_1.writeFLOAT(colorMatrix[_local_2]);
                _local_2++;
            };
        }

        override public function clone():IFilter
        {
            var _local_2:uint;
            var _local_1:FilterColorMatrix = new FilterColorMatrix(id);
            _local_2 = 0;
            while (_local_2 < 20)
            {
                _local_1.colorMatrix.push(colorMatrix[_local_2]);
                _local_2++;
            };
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = StringUtils.repeat((_arg_1 + 2));
            return ((((((((((((((((((((((((((((((((((((((((((((((("[ColorMatrixFilter]\n" + _local_2) + "[R] ") + colorMatrix[0]) + ", ") + colorMatrix[1]) + ", ") + colorMatrix[2]) + ", ") + colorMatrix[3]) + ", ") + colorMatrix[4]) + "\n") + _local_2) + "[G] ") + colorMatrix[5]) + ", ") + colorMatrix[6]) + ", ") + colorMatrix[7]) + ", ") + colorMatrix[8]) + ", ") + colorMatrix[9]) + "\n") + _local_2) + "[B] ") + colorMatrix[10]) + ", ") + colorMatrix[11]) + ", ") + colorMatrix[12]) + ", ") + colorMatrix[13]) + ", ") + colorMatrix[14]) + "\n") + _local_2) + "[A] ") + colorMatrix[15]) + ", ") + colorMatrix[16]) + ", ") + colorMatrix[17]) + ", ") + colorMatrix[18]) + ", ") + colorMatrix[19]);
        }


    }
}


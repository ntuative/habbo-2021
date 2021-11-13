package com.codeazur.as3swf.utils
{
    import com.codeazur.as3swf.data.SWFMatrix;

    public class MatrixUtils 
    {


        public static function interpolate(_arg_1:SWFMatrix, _arg_2:SWFMatrix, _arg_3:Number):SWFMatrix
        {
            var _local_4:SWFMatrix = new SWFMatrix();
            _local_4.scaleX = (_arg_1.scaleX + ((_arg_2.scaleX - _arg_1.scaleX) * _arg_3));
            _local_4.scaleY = (_arg_1.scaleY + ((_arg_2.scaleY - _arg_1.scaleY) * _arg_3));
            _local_4.rotateSkew0 = (_arg_1.rotateSkew0 + ((_arg_2.rotateSkew0 - _arg_1.rotateSkew0) * _arg_3));
            _local_4.rotateSkew1 = (_arg_1.rotateSkew1 + ((_arg_2.rotateSkew1 - _arg_1.rotateSkew1) * _arg_3));
            _local_4._SafeStr_290 = (_arg_1._SafeStr_290 + ((_arg_2._SafeStr_290 - _arg_1._SafeStr_290) * _arg_3));
            _local_4._SafeStr_291 = (_arg_1._SafeStr_291 + ((_arg_2._SafeStr_291 - _arg_1._SafeStr_291) * _arg_3));
            return (_local_4);
        }


    }
}


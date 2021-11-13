package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFShapeRecord 
    {

        public static const _SafeStr_709:uint = 0;
        public static const _SafeStr_710:uint = 1;
        public static const TYPE_STYLECHANGE:uint = 2;
        public static const TYPE_STRAIGHTEDGE:uint = 3;
        public static const TYPE_CURVEDEDGE:uint = 4;

        public function SWFShapeRecord(_arg_1:SWFData=null, _arg_2:uint=1)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1, _arg_2);
            };
        }

        public function get type():uint
        {
            return (0);
        }

        public function get isEdgeRecord():Boolean
        {
            return ((type == 3) || (type == 4));
        }

        public function parse(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
        }

        public function publish(_arg_1:SWFData=null, _arg_2:uint=1):void
        {
        }

        public function clone():SWFShapeRecord
        {
            return (null);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ("[SWFShapeRecord]");
        }


    }
}


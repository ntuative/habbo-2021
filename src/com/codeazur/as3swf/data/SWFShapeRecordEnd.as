package com.codeazur.as3swf.data
{
    public class SWFShapeRecordEnd extends SWFShapeRecord 
    {


        override public function clone():SWFShapeRecord
        {
            return (new SWFShapeRecordEnd());
        }

        override public function get type():uint
        {
            return (1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ("[SWFShapeRecordEnd]");
        }


    }
}
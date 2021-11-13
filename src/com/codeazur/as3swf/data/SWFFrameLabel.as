package com.codeazur.as3swf.data
{
    public class SWFFrameLabel 
    {

        public var frameNumber:uint;
        public var name:String;

        public function SWFFrameLabel(_arg_1:uint, _arg_2:String)
        {
            this.frameNumber = _arg_1;
            this.name = _arg_2;
        }

        public function toString():String
        {
            return ((("Frame: " + frameNumber) + ", Name: ") + name);
        }


    }
}
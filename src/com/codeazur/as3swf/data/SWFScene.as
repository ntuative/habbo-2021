package com.codeazur.as3swf.data
{
    public class SWFScene 
    {

        public var offset:uint;
        public var name:String;

        public function SWFScene(_arg_1:uint, _arg_2:String)
        {
            this.offset = _arg_1;
            this.name = _arg_2;
        }

        public function toString():String
        {
            return ((("Frame: " + offset) + ", Name: ") + name);
        }


    }
}
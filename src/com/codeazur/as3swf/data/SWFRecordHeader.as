package com.codeazur.as3swf.data
{
    public class SWFRecordHeader 
    {

        public var type:uint;
        public var contentLength:uint;
        public var headerLength:uint;

        public function SWFRecordHeader(_arg_1:uint, _arg_2:uint, _arg_3:uint)
        {
            this.type = _arg_1;
            this.contentLength = _arg_2;
            this.headerLength = _arg_3;
        }

        public function get tagLength():uint
        {
            return (headerLength + contentLength);
        }

        public function toString():String
        {
            return ((((("[SWFRecordHeader] type: " + type) + ", headerLength: ") + headerLength) + ", contentlength: ") + contentLength);
        }


    }
}
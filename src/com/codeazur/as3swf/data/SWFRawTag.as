package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFRawTag 
    {

        public var header:SWFRecordHeader;
        public var bytes:SWFData;

        public function SWFRawTag(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            var _local_3:uint = _arg_1.position;
            header = _arg_1.readTagHeader();
            bytes = new SWFData();
            var _local_2:uint = _arg_1.position;
            _arg_1.position = _local_3;
            _arg_1.readBytes(bytes, 0, header.tagLength);
            _arg_1.position = _local_2;
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeBytes(bytes);
        }


    }
}
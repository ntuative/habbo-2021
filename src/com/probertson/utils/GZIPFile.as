package com.probertson.utils
{
    import flash.utils.ByteArray;

    public class GZIPFile 
    {

        private var _gzipFileName:String;
        private var _SafeStr_774:ByteArray;
        private var _headerFileName:String;
        private var _headerComment:String;
        private var _fileModificationTime:Date;
        private var _originalFileSize:uint;

        public function GZIPFile(_arg_1:ByteArray, _arg_2:uint, _arg_3:Date, _arg_4:String="", _arg_5:String=null, _arg_6:String=null)
        {
            _SafeStr_774 = _arg_1;
            _originalFileSize = _arg_2;
            _fileModificationTime = _arg_3;
            _gzipFileName = _arg_4;
            _headerFileName = _arg_5;
            _headerComment = _arg_6;
        }

        public function get gzipFileName():String
        {
            return (_gzipFileName);
        }

        public function get headerFileName():String
        {
            return (_headerFileName);
        }

        public function get headerComment():String
        {
            return (_headerComment);
        }

        public function get fileModificationTime():Date
        {
            return (_fileModificationTime);
        }

        public function get originalFileSize():uint
        {
            return (_originalFileSize);
        }

        public function getCompressedData():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _SafeStr_774.position = 0;
            _SafeStr_774.readBytes(_local_1, 0, _SafeStr_774.length);
            return (_local_1);
        }


    }
}


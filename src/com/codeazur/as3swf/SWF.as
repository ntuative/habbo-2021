package com.codeazur.as3swf
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.events.SWFProgressEvent;

    public class SWF extends SWFTimelineContainer
    {

        public static const COMPRESSION_METHOD_ZLIB:String = "zlib";
        public static const COMPRESSION_METHOD_LZMA:String = "lzma";
        protected static const FILE_LENGTH_POS:uint = 4;
        protected static const COMPRESSION_START_POS:uint = 8;

        public var signature:String;
        public var version:int;
        public var fileLength:uint;
        public var fileLengthCompressed:uint;
        public var _SafeStr_280:SWFRectangle;
        public var frameRate:Number;
        public var frameCount:uint;
        public var compressed:Boolean;
        public var compressionMethod:String;
        protected var bytes:SWFData;

        public function SWF(_arg_1:ByteArray=null)
        {
            bytes = new SWFData();
            if (_arg_1 != null)
            {
                loadBytes(_arg_1);
            }
            else
            {
                version = 10;
                fileLength = 0;
                fileLengthCompressed = 0;
                _SafeStr_280 = new SWFRectangle();
                frameRate = 50;
                frameCount = 1;
                compressed = true;
                compressionMethod = "zlib";
            };
        }

        public function loadBytes(_arg_1:ByteArray):void
        {
            bytes.length = 0;
            _arg_1.position = 0;
            _arg_1.readBytes(bytes);
            parse(bytes);
        }

        public function loadBytesAsync(_arg_1:ByteArray):void
        {
            bytes.length = 0;
            _arg_1.position = 0;
            _arg_1.readBytes(bytes);
            parseAsync(bytes);
        }

        public function parse(_arg_1:SWFData):void
        {
            bytes = _arg_1;
            parseHeader();
            parseTags(_arg_1, version);
        }

        public function parseAsync(_arg_1:SWFData):void
        {
            bytes = _arg_1;
            parseHeader();
            parseTagsAsync(_arg_1, version);
        }

        public function publish(_arg_1:ByteArray):void
        {
            var _local_2:SWFData = new SWFData();
            publishHeader(_local_2);
            publishTags(_local_2, version);
            publishFinalize(_local_2);
            _arg_1.writeBytes(_local_2);
        }

        public function publishAsync(_arg_1:ByteArray):void
        {
            var ba:ByteArray = _arg_1;
            var data:SWFData = new SWFData();
            publishHeader(data);
            publishTagsAsync(data, version);
            addEventListener("complete", function (_arg_1:SWFProgressEvent):void
            {
                removeEventListener("complete", arguments.callee);
                publishFinalize(data);
                ba.length = 0;
                ba.writeBytes(data);
            }, false, 2147483647);
        }

        protected function parseHeader():void
        {
            signature = "";
            compressed = false;
            compressionMethod = "zlib";
            bytes.position = 0;
            var _local_1:uint = bytes.readUI8();
            if (_local_1 == 67)
            {
                compressed = true;
            }
            else
            {
                if (_local_1 == 90)
                {
                    compressed = true;
                    compressionMethod = "lzma";
                }
                else
                {
                    if (_local_1 != 70)
                    {
                        throw (new Error((("Not a SWF. First signature byte is 0x" + _local_1.toString(16)) + " (expected: 0x43 or 0x5A or 0x46)")));
                    };
                };
            };
            signature = (signature + String.fromCharCode(_local_1));
            _local_1 = bytes.readUI8();
            if (_local_1 != 87)
            {
                throw (new Error((("Not a SWF. Second signature byte is 0x" + _local_1.toString(16)) + " (expected: 0x57)")));
            };
            signature = (signature + String.fromCharCode(_local_1));
            _local_1 = bytes.readUI8();
            if (_local_1 != 83)
            {
                throw (new Error((("Not a SWF. Third signature byte is 0x" + _local_1.toString(16)) + " (expected: 0x53)")));
            };
            signature = (signature + String.fromCharCode(_local_1));
            version = bytes.readUI8();
            fileLength = bytes.readUI32();
            fileLengthCompressed = bytes.length;
            if (compressed)
            {
                bytes.swfUncompress(compressionMethod, fileLength);
            };
            _SafeStr_280 = bytes.readRECT();
            frameRate = bytes.readFIXED8();
            frameCount = bytes.readUI16();
        }

        protected function publishHeader(_arg_1:SWFData):void
        {
            var _local_2:uint = 70;
            if (compressed)
            {
                if (compressionMethod == "zlib")
                {
                    _local_2 = 67;
                }
                else
                {
                    if (compressionMethod == "lzma")
                    {
                        _local_2 = 90;
                    };
                };
            };
            _arg_1.writeUI8(_local_2);
            _arg_1.writeUI8(87);
            _arg_1.writeUI8(83);
            _arg_1.writeUI8(version);
            _arg_1.writeUI32(0);
            _arg_1.writeRECT(_SafeStr_280);
            _arg_1.writeFIXED8(frameRate);
            _arg_1.writeUI16(frameCount);
        }

        protected function publishFinalize(_arg_1:SWFData):void
        {
            fileLength = (fileLengthCompressed = _arg_1.length);
            if (compressed)
            {
                compressionMethod = "zlib";
                _arg_1.position = 8;
                _arg_1.swfCompress(compressionMethod);
                fileLengthCompressed = _arg_1.length;
            };
            var _local_2:uint = _arg_1.position;
            _arg_1.position = 4;
            _arg_1.writeUI32(fileLength);
            _arg_1.position = 0;
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = ((("[SWF]\n  Header:\n    Version: " + version) + "\n") + "    Compression: ");
            if (compressed)
            {
                if (compressionMethod == "zlib")
                {
                    _local_2 = (_local_2 + "ZLIB");
                }
                else
                {
                    if (compressionMethod == "lzma")
                    {
                        _local_2 = (_local_2 + "LZMA");
                    }
                    else
                    {
                        _local_2 = (_local_2 + "Unknown");
                    };
                };
            }
            else
            {
                _local_2 = (_local_2 + "None");
            };
            return (((((((((((((((_local_2 + "\n    FileLength: ") + fileLength) + "\n") + "    FileLengthCompressed: ") + fileLengthCompressed) + "\n") + "    FrameSize: ") + _SafeStr_280.toStringSize()) + "\n") + "    FrameRate: ") + frameRate) + "\n") + "    FrameCount: ") + frameCount) + super.toString(_arg_1));
        }

        override public function dispose():void
        {
            if (bytes)
            {
                bytes.clear();
                bytes = null;
            };
            super.dispose();
        }


    }
}
package deng.fzip
{
    import flash.utils.describeType;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import deng.utils.ChecksumUtil;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import flash.utils.*;

    public class FZipFile
    {

        public static const COMPRESSION_NONE:int = 0;
        public static const COMPRESSION_SHRUNK:int = 1;
        public static const COMPRESSION_REDUCED_1:int = 2;
        public static const COMPRESSION_REDUCED_2:int = 3;
        public static const COMPRESSION_REDUCED_3:int = 4;
        public static const COMPRESSION_REDUCED_4:int = 5;
        public static const COMPRESSION_IMPLODED:int = 6;
        public static const COMPRESSION_TOKENIZED:int = 7;
        public static const COMPRESSION_DEFLATED:int = 8;
        public static const COMPRESSION_DEFLATED_EXT:int = 9;
        public static const COMPRESSION_IMPLODED_PKWARE:int = 10;

        protected static var HAS_UNCOMPRESS:Boolean = (describeType(ByteArray).factory.method.(@name == "uncompress").parameter.length() > 0);
        protected static var _SafeStr_4535:Boolean = (describeType(ByteArray).factory.method.(@name == "inflate").length() > 0);

        protected var _SafeStr_4536:int = 0;
        protected var _versionNumber:String = "2.0";
        protected var _SafeStr_4537:int = 8;
        protected var _SafeStr_4538:Boolean = false;
        protected var _SafeStr_4539:int = -1;
        protected var _SafeStr_4540:int = -1;
        protected var _deflateSpeedOption:int = -1;
        protected var _SafeStr_4541:Boolean = false;
        protected var _SafeStr_4542:Boolean = false;
        protected var _SafeStr_3952:Date;
        protected var _adler32:uint;
        protected var _hasAdler32:Boolean = false;
        protected var _sizeFilename:uint = 0;
        protected var _SafeStr_4543:uint = 0;
        protected var _filename:String = "";
        protected var _SafeStr_4544:String;
        protected var _SafeStr_4545:Dictionary;
        protected var _SafeStr_4546:String = "";
        protected var _content:ByteArray;
        internal var _crc32:uint;
        internal var _sizeCompressed:uint = 0;
        internal var _sizeUncompressed:uint = 0;
        protected var isCompressed:Boolean = false;
        protected var _SafeStr_4531:Function = parseFileHead;

        public function FZipFile(_arg_1:String="utf-8")
        {
            _SafeStr_4544 = _arg_1;
            _SafeStr_4545 = new Dictionary();
            _content = new ByteArray();
            _content.endian = "bigEndian";
        }

        public function get date():Date
        {
            return (_SafeStr_3952);
        }

        public function set date(_arg_1:Date):void
        {
            _SafeStr_3952 = ((_arg_1 != null) ? _arg_1 : new Date());
        }

        public function get filename():String
        {
            return (_filename);
        }

        public function set filename(_arg_1:String):void
        {
            _filename = _arg_1;
        }

        internal function get hasDataDescriptor():Boolean
        {
            return (_SafeStr_4541);
        }

        public function get content():ByteArray
        {
            if (isCompressed)
            {
                uncompress();
            };
            return (_content);
        }

        public function set content(_arg_1:ByteArray):void
        {
            setContent(_arg_1);
        }

        public function setContent(_arg_1:ByteArray, _arg_2:Boolean=true):void
        {
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _arg_1.position = 0;
                _arg_1.readBytes(_content, 0, _arg_1.length);
                _crc32 = ChecksumUtil.CRC32(_content);
                _hasAdler32 = false;
            }
            else
            {
                _content.length = 0;
                _content.position = 0;
                isCompressed = false;
            };
            if (_arg_2)
            {
                compress();
            }
            else
            {
                _sizeUncompressed = (_sizeCompressed = _content.length);
            };
        }

        public function get versionNumber():String
        {
            return (_versionNumber);
        }

        public function get sizeCompressed():uint
        {
            return (_sizeCompressed);
        }

        public function get sizeUncompressed():uint
        {
            return (_sizeUncompressed);
        }

        public function getContentAsString(_arg_1:Boolean=true, _arg_2:String="utf-8"):String
        {
            var _local_3:String;
            if (isCompressed)
            {
                uncompress();
            };
            _content.position = 0;
            if (_arg_2 == "utf-8")
            {
                _local_3 = _content.readUTFBytes(_content.bytesAvailable);
            }
            else
            {
                _local_3 = _content.readMultiByte(_content.bytesAvailable, _arg_2);
            };
            _content.position = 0;
            if (_arg_1)
            {
                compress();
            };
            return (_local_3);
        }

        public function setContentAsString(_arg_1:String, _arg_2:String="utf-8", _arg_3:Boolean=true):void
        {
            _content.length = 0;
            _content.position = 0;
            isCompressed = false;
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                if (_arg_2 == "utf-8")
                {
                    _content.writeUTFBytes(_arg_1);
                }
                else
                {
                    _content.writeMultiByte(_arg_1, _arg_2);
                };
                _crc32 = ChecksumUtil.CRC32(_content);
                _hasAdler32 = false;
            };
            if (_arg_3)
            {
                compress();
            }
            else
            {
                _sizeUncompressed = (_sizeCompressed = _content.length);
            };
        }

        public function serialize(_arg_1:IDataOutput, _arg_2:Boolean, _arg_3:Boolean=false, _arg_4:uint=0):uint
        {
            var _local_7:ByteArray;
            var _local_14:Boolean;
            if (_arg_1 == null)
            {
                return (0);
            };
            if (_arg_3)
            {
                _arg_1.writeUnsignedInt(33639248);
                _arg_1.writeShort(((_SafeStr_4536 << 8) | 0x14));
            }
            else
            {
                _arg_1.writeUnsignedInt(67324752);
            };
            _arg_1.writeShort(((_SafeStr_4536 << 8) | 0x14));
            _arg_1.writeShort(((_SafeStr_4544 == "utf-8") ? 0x0800 : 0));
            _arg_1.writeShort(((isCompressed) ? 8 : 0));
            var _local_6:Date = ((_SafeStr_3952 != null) ? _SafeStr_3952 : new Date());
            var _local_11:uint = ((_local_6.getSeconds() | (_local_6.getMinutes() << 5)) | (_local_6.getHours() << 11));
            var _local_8:uint = ((_local_6.getDate() | ((_local_6.getMonth() + 1) << 5)) | ((_local_6.getFullYear() - 1980) << 9));
            _arg_1.writeShort(_local_11);
            _arg_1.writeShort(_local_8);
            _arg_1.writeUnsignedInt(_crc32);
            _arg_1.writeUnsignedInt(_sizeCompressed);
            _arg_1.writeUnsignedInt(_sizeUncompressed);
            var _local_16:ByteArray = new ByteArray();
            _local_16.endian = "littleEndian";
            if (_SafeStr_4544 == "utf-8")
            {
                _local_16.writeUTFBytes(_filename);
            }
            else
            {
                _local_16.writeMultiByte(_filename, _SafeStr_4544);
            };
            var _local_9:uint = _local_16.position;
            for (var _local_10:Object in _SafeStr_4545)
            {
                _local_7 = (_SafeStr_4545[_local_10] as ByteArray);
                if (_local_7 != null)
                {
                    _local_16.writeShort(int(_local_10));
                    _local_16.writeShort(_local_7.length);
                    _local_16.writeBytes(_local_7);
                };
            };
            if (_arg_2)
            {
                if (!_hasAdler32)
                {
                    _local_14 = isCompressed;
                    if (_local_14)
                    {
                        uncompress();
                    };
                    _adler32 = ChecksumUtil.Adler32(_content, 0, _content.length);
                    _hasAdler32 = true;
                    if (_local_14)
                    {
                        compress();
                    };
                };
                _local_16.writeShort(0xDADA);
                _local_16.writeShort(4);
                _local_16.writeUnsignedInt(_adler32);
            };
            var _local_15:uint = (_local_16.position - _local_9);
            if (((_arg_3) && (_SafeStr_4546.length > 0)))
            {
                if (_SafeStr_4544 == "utf-8")
                {
                    _local_16.writeUTFBytes(_SafeStr_4546);
                }
                else
                {
                    _local_16.writeMultiByte(_SafeStr_4546, _SafeStr_4544);
                };
            };
            var _local_5:uint = ((_local_16.position - _local_9) - _local_15);
            _arg_1.writeShort(_local_9);
            _arg_1.writeShort(_local_15);
            if (_arg_3)
            {
                _arg_1.writeShort(_local_5);
                _arg_1.writeShort(0);
                _arg_1.writeShort(0);
                _arg_1.writeUnsignedInt(0);
                _arg_1.writeUnsignedInt(_arg_4);
            };
            if (((_local_9 + _local_15) + _local_5) > 0)
            {
                _arg_1.writeBytes(_local_16);
            };
            var _local_13:uint;
            if (((!(_arg_3)) && (_content.length > 0)))
            {
                if (isCompressed)
                {
                    if (((HAS_UNCOMPRESS) || (_SafeStr_4535)))
                    {
                        _local_13 = _content.length;
                        _arg_1.writeBytes(_content, 0, _local_13);
                    }
                    else
                    {
                        _local_13 = (_content.length - 6);
                        _arg_1.writeBytes(_content, 2, _local_13);
                    };
                }
                else
                {
                    _local_13 = _content.length;
                    _arg_1.writeBytes(_content, 0, _local_13);
                };
            };
            var _local_12:uint = ((((30 + _local_9) + _local_15) + _local_5) + _local_13);
            if (_arg_3)
            {
                _local_12 = (_local_12 + 16);
            };
            return (_local_12);
        }

        internal function parse(_arg_1:IDataInput):Boolean
        {
            do
            {
            } while (((_arg_1.bytesAvailable) && (_SafeStr_4531(_arg_1))));
            return (_SafeStr_4531 === parseFileIdle);
        }

        protected function parseFileIdle(_arg_1:IDataInput):Boolean
        {
            return (false);
        }

        protected function parseFileHead(_arg_1:IDataInput):Boolean
        {
            if (_arg_1.bytesAvailable >= 30)
            {
                parseHead(_arg_1);
                if ((_sizeFilename + _SafeStr_4543) > 0)
                {
                    _SafeStr_4531 = parseFileHeadExt;
                }
                else
                {
                    _SafeStr_4531 = parseFileContent;
                };
                return (true);
            };
            return (false);
        }

        protected function parseFileHeadExt(_arg_1:IDataInput):Boolean
        {
            if (_arg_1.bytesAvailable >= (_sizeFilename + _SafeStr_4543))
            {
                parseHeadExt(_arg_1);
                _SafeStr_4531 = parseFileContent;
                return (true);
            };
            return (false);
        }

        protected function parseFileContent(_arg_1:IDataInput):Boolean
        {
            var _local_2:Boolean = true;
            if (_SafeStr_4541)
            {
                _SafeStr_4531 = parseFileIdle;
                _local_2 = false;
            }
            else
            {
                if (_sizeCompressed == 0)
                {
                    _SafeStr_4531 = parseFileIdle;
                }
                else
                {
                    if (_arg_1.bytesAvailable >= _sizeCompressed)
                    {
                        parseContent(_arg_1);
                        _SafeStr_4531 = parseFileIdle;
                    }
                    else
                    {
                        _local_2 = false;
                    };
                };
            };
            return (_local_2);
        }

        protected function parseHead(_arg_1:IDataInput):void
        {
            var _local_9:uint = _arg_1.readUnsignedShort();
            _SafeStr_4536 = (_local_9 >> 8);
            _versionNumber = ((Math.floor(((_local_9 & 0xFF) / 10)) + ".") + ((_local_9 & 0xFF) % 10));
            var _local_4:uint = _arg_1.readUnsignedShort();
            _SafeStr_4537 = _arg_1.readUnsignedShort();
            _SafeStr_4538 = (!((_local_4 & 0x01) === 0));
            _SafeStr_4541 = (!((_local_4 & 0x08) === 0));
            _SafeStr_4542 = (!((_local_4 & 0x20) === 0));
            if ((_local_4 & 0x0320) !== 0)
            {
                _SafeStr_4544 = "utf-8";
            };
            if (_SafeStr_4537 === 6)
            {
                _SafeStr_4539 = (((_local_4 & 0x02) !== 0) ? 0x2000 : 0x1000);
                _SafeStr_4540 = (((_local_4 & 0x04) !== 0) ? 3 : 2);
            }
            else
            {
                if (_SafeStr_4537 === 8)
                {
                    _deflateSpeedOption = ((_local_4 & 0x06) >> 1);
                };
            };
            var _local_2:uint = _arg_1.readUnsignedShort();
            var _local_10:uint = _arg_1.readUnsignedShort();
            var _local_3:* = (_local_2 & 0x1F);
            var _local_5:* = ((_local_2 & 0x07E0) >> 5);
            var _local_6:* = ((_local_2 & 0xF800) >> 11);
            var _local_11:* = (_local_10 & 0x1F);
            var _local_7:* = ((_local_10 & 0x01E0) >> 5);
            var _local_8:int = (((_local_10 & 0xFE00) >> 9) + 1980);
            _SafeStr_3952 = new Date(_local_8, (_local_7 - 1), _local_11, _local_6, _local_5, _local_3, 0);
            _crc32 = _arg_1.readUnsignedInt();
            _sizeCompressed = _arg_1.readUnsignedInt();
            _sizeUncompressed = _arg_1.readUnsignedInt();
            _sizeFilename = _arg_1.readUnsignedShort();
            _SafeStr_4543 = _arg_1.readUnsignedShort();
        }

        protected function parseHeadExt(_arg_1:IDataInput):void
        {
            var _local_5:uint;
            var _local_4:uint;
            var _local_2:ByteArray;
            if (_SafeStr_4544 == "utf-8")
            {
                _filename = _arg_1.readUTFBytes(_sizeFilename);
            }
            else
            {
                _filename = _arg_1.readMultiByte(_sizeFilename, _SafeStr_4544);
            };
            var _local_3:uint = _SafeStr_4543;
            while (_local_3 > 4)
            {
                _local_5 = _arg_1.readUnsignedShort();
                _local_4 = _arg_1.readUnsignedShort();
                if (_local_4 > _local_3)
                {
                    throw (new Error((("Parse error in file " + _filename) + ": Extra field data size too big.")));
                };
                if (((_local_5 === 0xDADA) && (_local_4 === 4)))
                {
                    _adler32 = _arg_1.readUnsignedInt();
                    _hasAdler32 = true;
                }
                else
                {
                    if (_local_4 > 0)
                    {
                        _local_2 = new ByteArray();
                        _arg_1.readBytes(_local_2, 0, _local_4);
                        _SafeStr_4545[_local_5] = _local_2;
                    };
                };
                _local_3 = (_local_3 - (_local_4 + 4));
            };
            if (_local_3 > 0)
            {
                _arg_1.readBytes(new ByteArray(), 0, _local_3);
            };
        }

        internal function parseContent(_arg_1:IDataInput):void
        {
            var _local_2:uint;
            if (((_SafeStr_4537 === 8) && (!(_SafeStr_4538))))
            {
                if (((HAS_UNCOMPRESS) || (_SafeStr_4535)))
                {
                    _arg_1.readBytes(_content, 0, _sizeCompressed);
                }
                else
                {
                    if (_hasAdler32)
                    {
                        _content.writeByte(120);
                        _local_2 = (((~(_deflateSpeedOption)) << 6) & 0xC0);
                        _local_2 = (_local_2 + (31 - ((0x7800 | _local_2) % 31)));
                        _content.writeByte(_local_2);
                        _arg_1.readBytes(_content, 2, _sizeCompressed);
                        _content.position = _content.length;
                        _content.writeUnsignedInt(_adler32);
                    }
                    else
                    {
                        throw (new Error("Adler32 checksum not found."));
                    };
                };
                isCompressed = true;
            }
            else
            {
                if (_SafeStr_4537 == 0)
                {
                    _arg_1.readBytes(_content, 0, _sizeCompressed);
                    isCompressed = false;
                }
                else
                {
                    throw (new Error((("Compression method " + _SafeStr_4537) + " is not supported.")));
                };
            };
            _content.position = 0;
        }

        protected function compress():void
        {
            if (!isCompressed)
            {
                if (_content.length > 0)
                {
                    _content.position = 0;
                    _sizeUncompressed = _content.length;
                    if (_SafeStr_4535)
                    {
                        _content.deflate();
                        _sizeCompressed = _content.length;
                    }
                    else
                    {
                        if (HAS_UNCOMPRESS)
                        {
                            _content.compress.apply(_content, ["deflate"]);
                            _sizeCompressed = _content.length;
                        }
                        else
                        {
                            _content.compress();
                            _sizeCompressed = (_content.length - 6);
                        };
                    };
                    _content.position = 0;
                    isCompressed = true;
                }
                else
                {
                    _sizeCompressed = 0;
                    _sizeUncompressed = 0;
                };
            };
        }

        protected function uncompress():void
        {
            if (((isCompressed) && (_content.length > 0)))
            {
                _content.position = 0;
                if (_SafeStr_4535)
                {
                    _content.inflate();
                }
                else
                {
                    if (HAS_UNCOMPRESS)
                    {
                        _content.uncompress.apply(_content, ["deflate"]);
                    }
                    else
                    {
                        _content.uncompress();
                    };
                };
                _content.position = 0;
                isCompressed = false;
            };
        }

        public function toString():String
        {
            return ((((((((((((((((((((((((("[FZipFile]\n  name:" + _filename) + "\n  date:") + _SafeStr_3952) + "\n  sizeCompressed:") + _sizeCompressed) + "\n  sizeUncompressed:") + _sizeUncompressed) + "\n  versionHost:") + _SafeStr_4536) + "\n  versionNumber:") + _versionNumber) + "\n  compressionMethod:") + _SafeStr_4537) + "\n  encrypted:") + _SafeStr_4538) + "\n  hasDataDescriptor:") + _SafeStr_4541) + "\n  hasCompressedPatchedData:") + _SafeStr_4542) + "\n  filenameEncoding:") + _SafeStr_4544) + "\n  crc32:") + _crc32.toString(16)) + "\n  adler32:") + _adler32.toString(16));
        }


    }
}
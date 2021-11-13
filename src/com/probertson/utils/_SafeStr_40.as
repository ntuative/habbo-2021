package com.probertson.utils
{
    import flash.utils.ByteArray;
    import flash.system.Capabilities;
    import flash.errors.IllegalOperationError;

    public class _SafeStr_40 
    {


        public function compressToByteArray(_arg_1:ByteArray, _arg_2:Date=null):ByteArray
        {
            var _local_3:uint;
            if (_arg_1 == null)
            {
                throw (new ArgumentError("src can't be null."));
            };
            var _local_12:uint = _arg_1.position;
            var _local_14:ByteArray = new ByteArray();
            _local_14.writeBytes(_arg_1);
            var _local_6:ByteArray = new ByteArray();
            _local_6.endian = "littleEndian";
            var _local_10:uint = 31;
            _local_6.writeByte(_local_10);
            var _local_9:uint = 139;
            _local_6.writeByte(_local_9);
            var _local_5:uint = 8;
            _local_6.writeByte(_local_5);
            var _local_4:int = parseInt("00000000", 2);
            _local_6.writeByte(_local_4);
            var _local_7:uint = ((_arg_2 == null) ? 0 : _arg_2.time);
            _local_6.writeUnsignedInt(_local_7);
            var _local_15:uint = parseInt("00000100", 2);
            _local_6.writeByte(_local_15);
            if (Capabilities.os.indexOf("Windows") >= 0)
            {
                _local_3 = 11;
            }
            else
            {
                if (Capabilities.os.indexOf("Mac OS") >= 0)
                {
                    _local_3 = 7;
                }
                else
                {
                    _local_3 = 3;
                };
            };
            _local_6.writeByte(_local_3);
            var _local_8:CRC32Generator = new CRC32Generator();
            var _local_13:uint = _local_8.generateCRC32(_local_14);
            var _local_11:uint = (_local_14.length % Math.pow(2, 32));
            _local_14.deflate();
            _local_6.writeBytes(_local_14, 0, _local_14.length);
            _local_6.writeUnsignedInt(_local_13);
            _local_6.writeUnsignedInt(_local_11);
            return (_local_6);
        }

        public function uncompressToByteArray(_arg_1:ByteArray):ByteArray
        {
            var _local_3:GZIPFile;
            _local_3 = parseGZIPData(_arg_1);
            var _local_2:ByteArray = _local_3.getCompressedData();
            try
            {
                _local_2.inflate();
            }
            catch(error:Error)
            {
                throw (new IllegalOperationError("The specified source is not a GZIP file format file or data."));
            };
            return (_local_2);
        }

        public function parseGZIPData(_arg_1:ByteArray, _arg_2:String=""):GZIPFile
        {
            var _local_9:String;
            var _local_4:ByteArray;
            var _local_17:String;
            var _local_24:ByteArray;
            var _local_12:int;
            if (_arg_1 == null)
            {
                throw (new ArgumentError("The srcBytes ByteArray can't be null."));
            };
            _arg_1.endian = "littleEndian";
            var _local_23:uint = _arg_1.readUnsignedByte();
            if (_local_23 != 31)
            {
                throw (new IllegalOperationError("The specified data is not in GZIP file format structure."));
            };
            var _local_21:uint = _arg_1.readUnsignedByte();
            if (_local_21 != 139)
            {
                throw (new IllegalOperationError("The specified data is not in GZIP file format structure."));
            };
            var _local_20:uint = _arg_1.readUnsignedByte();
            if (_local_20 != 8)
            {
                throw (new IllegalOperationError("The specified data is not in GZIP file format structure."));
            };
            var _local_6:int = _arg_1.readByte();
            var _local_13:* = (((_local_6 >> 7) & 0x01) == 1);
            var _local_18:* = (((_local_6 >> 6) & 0x01) == 1);
            var _local_15:* = (((_local_6 >> 5) & 0x01) == 1);
            var _local_22:* = (((_local_6 >> 4) & 0x01) == 1);
            var _local_3:* = (((_local_6 >> 3) & 0x01) == 1);
            var _local_8:Boolean;
            _local_8 = ((((_local_6 >> 2) & 0x01) == 1) ? true : _local_8);
            _local_8 = ((((_local_6 >> 1) & 0x01) == 1) ? true : _local_8);
            _local_8 = (((_local_6 & 0x01) == 1) ? true : _local_8);
            if (_local_8)
            {
                throw (new IllegalOperationError("The specified data is not in GZIP file format structure."));
            };
            var _local_7:uint = _arg_1.readUnsignedInt();
            var _local_25:uint = _arg_1.readUnsignedByte();
            var _local_16:uint = _arg_1.readUnsignedByte();
            if (_local_15)
            {
                _local_9 = _arg_1.readUTF();
            };
            var _local_14:String;
            if (_local_22)
            {
                _local_4 = new ByteArray();
                while (_arg_1.readUnsignedByte() != 0)
                {
                    _arg_1.position = (_arg_1.position - 1);
                    _local_4.writeByte(_arg_1.readByte());
                };
                _local_4.position = 0;
                _local_14 = _local_4.readUTFBytes(_local_4.length);
            };
            if (_local_3)
            {
                _local_24 = new ByteArray();
                while (_arg_1.readUnsignedByte() != 0)
                {
                    _arg_1.position = (_arg_1.position - 1);
                    _local_24.writeByte(_arg_1.readByte());
                };
                _local_24.position = 0;
                _local_17 = _local_24.readUTFBytes(_local_24.length);
            };
            if (_local_18)
            {
                _local_12 = _arg_1.readUnsignedShort();
            };
            var _local_19:int = ((_arg_1.length - _arg_1.position) - 8);
            var _local_5:ByteArray = new ByteArray();
            _arg_1.readBytes(_local_5, 0, _local_19);
            var _local_11:uint = _arg_1.readUnsignedInt();
            var _local_10:uint = _arg_1.readUnsignedInt();
            return (new GZIPFile(_local_5, _local_10, new Date(_local_7), _arg_2, _local_14, _local_17));
        }


    }
}


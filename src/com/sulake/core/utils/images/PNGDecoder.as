package com.sulake.core.utils.images
{
    import flash.utils.ByteArray;
    import flash.geom.Matrix;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    public class PNGDecoder 
    {

        private const _SafeStr_856:uint = 1229472850;
        private const PLTE:uint = 1347179589;
        private const IDAT:uint = 1229209940;
        private const IEND:uint = 1229278788;

        private var imgWidth:uint = 0;
        private var _SafeStr_857:uint = 0;
        private var bitDepth:uint = 0;
        private var _SafeStr_858:uint = 0;
        private var compressionMethod:uint = 0;
        private var _SafeStr_859:uint = 0;
        private var interlaceMethod:uint = 0;
        private var _SafeStr_860:Array;
        private var input:ByteArray;
        private var output:ByteArray;


        public function decode(_arg_1:ByteArray):BitmapData
        {
            var _local_3:int;
            var _local_2:Matrix;
            _SafeStr_860 = [];
            input = new ByteArray();
            output = new ByteArray();
            input = _arg_1;
            input.position = 0;
            if (!readSignature())
            {
                throw (new Error("wrong signature"));
            };
            getChunks();
            _local_3 = 0;
            while (_local_3 < _SafeStr_860.length)
            {
                switch (_SafeStr_860[_local_3].type)
                {
                    case 1229472850:
                        processIHDR(_local_3);
                        break;
                    case 1229209940:
                        processIDAT(_local_3);
                };
                _local_3++;
            };
            var _local_5:BitmapData = new BitmapData(imgWidth, _SafeStr_857);
            var _local_4:BitmapData = new BitmapData(imgWidth, _SafeStr_857, true, 0xFFFFFF);
            if (((output.length > 0) && (((imgWidth * _SafeStr_857) * 4) == output.length)))
            {
                output.position = 0;
                _local_5.setPixels(new Rectangle(0, 0, imgWidth, _SafeStr_857), output);
                _local_2 = new Matrix();
                _local_2.scale(-1, -1);
                _local_2.translate(imgWidth, _SafeStr_857);
                _local_4.draw(_local_5, _local_2);
            };
            return (_local_4);
        }

        private function processIHDR(_arg_1:uint):void
        {
            input.position = _SafeStr_860[_arg_1].position;
            imgWidth = input.readUnsignedInt();
            _SafeStr_857 = input.readUnsignedInt();
            bitDepth = input.readUnsignedByte();
            _SafeStr_858 = input.readUnsignedByte();
            compressionMethod = input.readUnsignedByte();
            _SafeStr_859 = input.readUnsignedByte();
            interlaceMethod = input.readUnsignedByte();
        }

        private function processIDAT(_arg_1:uint):void
        {
            var _local_7:int;
            var _local_2:uint;
            var _local_3:uint;
            var _local_6:uint;
            var _local_4:uint;
            var _local_5:ByteArray = new ByteArray();
            var _local_8:uint = (imgWidth * 4);
            _local_5.writeBytes(input, _SafeStr_860[_arg_1].position, _SafeStr_860[_arg_1].length);
            _local_5.uncompress();
            _local_7 = (_local_5.length - 1);
            while (_local_7 > 0)
            {
                if ((_local_7 % (_local_8 + 1)) != 0)
                {
                    _local_2 = _local_5[_local_7];
                    _local_3 = _local_5[(_local_7 - 1)];
                    _local_6 = _local_5[(_local_7 - 2)];
                    _local_4 = _local_5[(_local_7 - 3)];
                    output.writeByte(_local_2);
                    output.writeByte(_local_4);
                    output.writeByte(_local_6);
                    output.writeByte(_local_3);
                    _local_7 = (_local_7 - 3);
                };
                _local_7--;
            };
        }

        private function getChunks():void
        {
            var _local_2:uint;
            var _local_1:uint;
            var _local_3:uint;
            var _local_4:int = input.length;
            while (input.position < _local_4)
            {
                _local_1 = input.readUnsignedInt();
                _local_3 = input.readUnsignedInt();
                _local_2 = input.position;
                input.position = (input.position + _local_1);
                input.position = (input.position + 4);
                _SafeStr_860.push({
                    "position":_local_2,
                    "length":_local_1,
                    "type":_local_3
                });
            };
        }

        private function readSignature():Boolean
        {
            return ((input.readUnsignedInt() == 2303741511) && (input.readUnsignedInt() == 218765834));
        }

        private function fixType(_arg_1:uint):String
        {
            var _local_2:String = "";
            var _local_3:String = _arg_1.toString(16);
            while (_local_3.length < 8)
            {
                _local_3 = ("0" + _local_3);
            };
            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_3.substr(0, 2), 16)));
            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_3.substr(2, 2), 16)));
            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_3.substr(4, 2), 16)));
            return (_local_2 + String.fromCharCode(parseInt(_local_3.substr(6, 2), 16)));
        }


    }
}


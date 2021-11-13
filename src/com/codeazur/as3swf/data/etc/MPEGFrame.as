package com.codeazur.as3swf.data.etc
{
    import flash.utils.ByteArray;

    public class MPEGFrame 
    {

        public static const MPEG_VERSION_1_0:uint = 0;
        public static const MPEG_VERSION_2_0:uint = 1;
        public static const MPEG_VERSION_2_5:uint = 2;
        public static const MPEG_LAYER_I:uint = 0;
        public static const MPEG_LAYER_II:uint = 1;
        public static const MPEG_LAYER_III:uint = 2;
        public static const CHANNEL_MODE_STEREO:uint = 0;
        public static const CHANNEL_MODE_JOINT_STEREO:uint = 1;
        public static const CHANNEL_MODE_DUAL:uint = 2;
        public static const CHANNEL_MODE_MONO:uint = 3;

        protected static var _SafeStr_680:Array = [[[0, 32, 96, 128, 160, 192, 224, 0x0100, 288, 320, 352, 384, 416, 448, -1], [0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 0x0100, 320, 384, -1], [0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 0x0100, 320, -1]], [[0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 0x0100, -1], [0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1], [0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1]]];
        protected static var _SafeStr_681:Array = [[44100, 48000, 0x7D00], [22050, 24000, 16000], [11025, 12000, 8000]];

        protected var _version:uint;
        protected var _SafeStr_682:uint;
        protected var _SafeStr_683:uint;
        protected var _SafeStr_684:uint;
        protected var _SafeStr_685:Boolean;
        protected var _SafeStr_686:uint;
        protected var _SafeStr_687:uint;
        protected var _SafeStr_688:Boolean;
        protected var _SafeStr_689:Boolean;
        protected var _emphasis:uint;
        protected var _header:ByteArray;
        protected var _SafeStr_690:ByteArray;
        protected var _SafeStr_691:ByteArray;
        protected var _SafeStr_692:Boolean;
        protected var _SafeStr_693:uint = 1152;

        public function MPEGFrame()
        {
            init();
        }

        public function get version():uint
        {
            return (_version);
        }

        public function get layer():uint
        {
            return (_SafeStr_682);
        }

        public function get bitrate():uint
        {
            return (_SafeStr_683);
        }

        public function get samplingrate():uint
        {
            return (_SafeStr_684);
        }

        public function get padding():Boolean
        {
            return (_SafeStr_685);
        }

        public function get channelMode():uint
        {
            return (_SafeStr_686);
        }

        public function get channelModeExt():uint
        {
            return (_SafeStr_687);
        }

        public function get copyright():Boolean
        {
            return (_SafeStr_688);
        }

        public function get original():Boolean
        {
            return (_SafeStr_689);
        }

        public function get emphasis():uint
        {
            return (_emphasis);
        }

        public function get hasCRC():Boolean
        {
            return (_SafeStr_692);
        }

        public function get crc():uint
        {
            _SafeStr_691.position = 0;
            return (_SafeStr_691.readUnsignedShort());
        }

        public function get samples():uint
        {
            return (_SafeStr_693);
        }

        public function get data():ByteArray
        {
            return (_SafeStr_690);
        }

        public function set data(_arg_1:ByteArray):void
        {
            _SafeStr_690 = _arg_1;
        }

        public function get size():uint
        {
            var _local_1:uint;
            if (layer == 0)
            {
                _local_1 = uint(Math.floor(((12000 * bitrate) / samplingrate)));
                if (padding)
                {
                    _local_1++;
                };
                _local_1 = (_local_1 << 2);
            }
            else
            {
                _local_1 = uint(Math.floor(((((version == 0) ? 144000 : 72000) * bitrate) / samplingrate)));
                if (padding)
                {
                    _local_1++;
                };
            };
            return ((_local_1 - 4) - ((hasCRC) ? 2 : 0));
        }

        public function setHeaderByteAt(_arg_1:uint, _arg_2:uint):void
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_3:uint;
            var _local_4:uint;
            switch (_arg_1)
            {
                case 0:
                    if (_arg_2 != 0xFF)
                    {
                        throw (new Error("Not a MPEG header."));
                    };
                    break;
                case 1:
                    if ((_arg_2 & 0xE0) != 224)
                    {
                        throw (new Error("Not a MPEG header."));
                    };
                    _local_5 = ((_arg_2 & 0x18) >> 3);
                    switch (_local_5)
                    {
                        case 3:
                            _version = 0;
                            break;
                        case 2:
                            _version = 1;
                            break;
                        default:
                            throw (new Error("Unsupported MPEG version."));
                    };
                    _local_6 = ((_arg_2 & 0x06) >> 1);
                    switch (_local_6)
                    {
                        case 1:
                            _SafeStr_682 = 2;
                            break;
                        default:
                            throw (new Error("Unsupported MPEG layer."));
                    };
                    _SafeStr_692 = (!(!((_arg_2 & 0x01) == 0)));
                    break;
                case 2:
                    _local_3 = ((_arg_2 & 0xF0) >> 4);
                    if (((_local_3 == 0) || (_local_3 == 15)))
                    {
                        throw (new Error("Unsupported bitrate index."));
                    };
                    _SafeStr_683 = _SafeStr_680[_version][_SafeStr_682][_local_3];
                    _local_4 = ((_arg_2 & 0x0C) >> 2);
                    if (_local_4 == 3)
                    {
                        throw (new Error("Unsupported samplingrate index."));
                    };
                    _SafeStr_684 = _SafeStr_681[_version][_local_4];
                    _SafeStr_685 = ((_arg_2 & 0x02) == 2);
                    break;
                case 3:
                    _SafeStr_686 = ((_arg_2 & 0xC0) >> 6);
                    _SafeStr_687 = ((_arg_2 & 0x30) >> 4);
                    _SafeStr_688 = ((_arg_2 & 0x08) == 8);
                    _SafeStr_689 = ((_arg_2 & 0x04) == 4);
                    _emphasis = (_arg_2 & 0x02);
                    break;
                default:
                    throw (new Error("Index out of bounds."));
            };
            _header[_arg_1] = _arg_2;
        }

        public function setCRCByteAt(_arg_1:uint, _arg_2:uint):void
        {
            if (_arg_1 > 1)
            {
                throw (new Error("Index out of bounds."));
            };
            _SafeStr_691[_arg_1] = _arg_2;
        }

        protected function init():void
        {
            _header = new ByteArray();
            _header.writeByte(0);
            _header.writeByte(0);
            _header.writeByte(0);
            _header.writeByte(0);
            _SafeStr_691 = new ByteArray();
            _SafeStr_691.writeByte(0);
            _SafeStr_691.writeByte(0);
        }

        public function getFrame():ByteArray
        {
            var _local_1:ByteArray = new ByteArray();
            _local_1.writeBytes(_header, 0, 4);
            if (hasCRC)
            {
                _local_1.writeBytes(_SafeStr_691, 0, 2);
            };
            _local_1.writeBytes(_SafeStr_690);
            return (_local_1);
        }

        public function toString():String
        {
            var _local_2:String = "MPEG ";
            switch (version)
            {
                case 0:
                    _local_2 = (_local_2 + "1.0 ");
                    break;
                case 1:
                    _local_2 = (_local_2 + "2.0 ");
                    break;
                case 2:
                    _local_2 = (_local_2 + "2.5 ");
                    break;
                default:
                    _local_2 = (_local_2 + "?.? ");
            };
            switch (layer)
            {
                case 0:
                    _local_2 = (_local_2 + "Layer I");
                    break;
                case 1:
                    _local_2 = (_local_2 + "Layer II");
                    break;
                case 2:
                    _local_2 = (_local_2 + "Layer III");
                    break;
                default:
                    _local_2 = (_local_2 + "Layer ?");
            };
            var _local_1:String = "unknown";
            switch (channelMode)
            {
                case 0:
                    _local_1 = "Stereo";
                    break;
                case 1:
                    _local_1 = "Joint stereo";
                    break;
                case 2:
                    _local_1 = "Dual channel";
                    break;
                case 3:
                    _local_1 = "Mono";
                default:
            };
            return (((((((((_local_2 + ", ") + bitrate) + " kbit/s, ") + samplingrate) + " Hz, ") + _local_1) + ", ") + size) + " bytes");
        }


    }
}


package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts.SoundCompression;
    import com.codeazur.as3swf.data.consts._SafeStr_77;
    import com.codeazur.as3swf.data.consts._SafeStr_79;
    import com.codeazur.as3swf.data.consts._SafeStr_82;
    import com.codeazur.as3swf.data.etc.MPEGFrame;

    public class TagDefineSound implements IDefinitionTag 
    {

        public static const TYPE:uint = 14;

        public var soundFormat:uint;
        public var soundRate:uint;
        public var soundSize:uint;
        public var soundType:uint;
        public var soundSampleCount:uint;
        protected var _SafeStr_720:uint;
        protected var _SafeStr_735:ByteArray;

        public function TagDefineSound()
        {
            _SafeStr_735 = new ByteArray();
        }

        public static function create(_arg_1:uint, _arg_2:uint=2, _arg_3:uint=3, _arg_4:uint=1, _arg_5:uint=1, _arg_6:uint=0, _arg_7:ByteArray=null):TagDefineSound
        {
            var _local_8:TagDefineSound = new TagDefineSound();
            _local_8._SafeStr_720 = _arg_1;
            _local_8.soundFormat = _arg_2;
            _local_8.soundRate = _arg_3;
            _local_8.soundSize = _arg_4;
            _local_8.soundType = _arg_5;
            _local_8.soundSampleCount = _arg_6;
            if (((!(_arg_7 == null)) && (_arg_7.length > 0)))
            {
                _local_8.soundData.writeBytes(_arg_7);
            };
            return (_local_8);
        }

        public static function createWithMP3(_arg_1:uint, _arg_2:ByteArray):TagDefineSound
        {
            var _local_3:TagDefineSound;
            if (((!(_arg_2 == null)) && (_arg_2.length > 0)))
            {
                _local_3 = new TagDefineSound();
                _local_3._SafeStr_720 = _arg_1;
                _local_3.processMP3(_arg_2);
                return (_local_3);
            };
            throw (new Error("No MP3 data."));
        }


        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get soundData():ByteArray
        {
            return (_SafeStr_735);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            soundFormat = _arg_1.readUB(4);
            soundRate = _arg_1.readUB(2);
            soundSize = _arg_1.readUB(1);
            soundType = _arg_1.readUB(1);
            soundSampleCount = _arg_1.readUI32();
            _arg_1.readBytes(_SafeStr_735, 0, (_arg_2 - 7));
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeUB(4, soundFormat);
            _local_3.writeUB(2, soundRate);
            _local_3.writeUB(1, soundSize);
            _local_3.writeUB(1, soundType);
            _local_3.writeUI32(soundSampleCount);
            if (_SafeStr_735.length > 0)
            {
                _local_3.writeBytes(_SafeStr_735);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineSound = new TagDefineSound();
            _local_1.characterId = characterId;
            _local_1.soundFormat = soundFormat;
            _local_1.soundRate = soundRate;
            _local_1.soundSize = soundSize;
            _local_1.soundType = soundType;
            _local_1.soundSampleCount = soundSampleCount;
            if (_SafeStr_735.length > 0)
            {
                _local_1.soundData.writeBytes(_SafeStr_735);
            };
            return (_local_1);
        }

        public function get type():uint
        {
            return (14);
        }

        public function get name():String
        {
            return ("DefineSound");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "SoundID: ") + characterId) + ", ") + "Format: ") + SoundCompression.toString(soundFormat)) + ", ") + "Rate: ") + _SafeStr_77.toString(soundRate)) + ", ") + "Size: ") + _SafeStr_79.toString(soundSize)) + ", ") + "Type: ") + _SafeStr_82.toString(soundType)) + ", ") + "Samples: ") + soundSampleCount);
        }

        internal function processMP3(_arg_1:ByteArray):void
        {
            var _local_6:uint;
            var _local_2:uint;
            var _local_3:uint = _arg_1.length;
            var _local_9:uint;
            var _local_4:Boolean = true;
            var _local_7:uint;
            var _local_5:uint;
            var _local_10:MPEGFrame = new MPEGFrame();
            var _local_8:String = "id3v2";
            while (_local_6 < _arg_1.length)
            {
                switch (_local_8)
                {
                    case "id3v2":
                        if ((((_arg_1[_local_6] == 73) && (_arg_1[(_local_6 + 1)] == 68)) && (_arg_1[(_local_6 + 2)] == 51)))
                        {
                            _local_6 = (_local_6 + (10 + ((((_arg_1[(_local_6 + 6)] << 21) | (_arg_1[(_local_6 + 7)] << 14)) | (_arg_1[(_local_6 + 8)] << 7)) | _arg_1[(_local_6 + 9)])));
                        };
                        _local_2 = _local_6;
                        _local_8 = "sync";
                        break;
                    case "sync":
                        if (((_arg_1[_local_6] == 0xFF) && ((_arg_1[(_local_6 + 1)] & 0xE0) == 224)))
                        {
                            _local_8 = "frame";
                        }
                        else
                        {
                            if ((((_arg_1[_local_6] == 84) && (_arg_1[(_local_6 + 1)] == 65)) && (_arg_1[(_local_6 + 2)] == 71)))
                            {
                                _local_3 = _local_6;
                                _local_6 = _arg_1.length;
                            }
                            else
                            {
                                _local_6++;
                            };
                        };
                        break;
                    case "frame":
                        _local_10.setHeaderByteAt(0, _arg_1[_local_6++]);
                        _local_10.setHeaderByteAt(1, _arg_1[_local_6++]);
                        _local_10.setHeaderByteAt(2, _arg_1[_local_6++]);
                        _local_10.setHeaderByteAt(3, _arg_1[_local_6++]);
                        if (_local_10.hasCRC)
                        {
                            _local_10.setCRCByteAt(0, _arg_1[_local_6++]);
                            _local_10.setCRCByteAt(1, _arg_1[_local_6++]);
                        };
                        if (_local_4)
                        {
                            _local_4 = false;
                            _local_7 = _local_10.samplingrate;
                            _local_5 = _local_10.channelMode;
                        };
                        _local_9 = (_local_9 + _local_10.samples);
                        _local_6 = (_local_6 + _local_10.size);
                        _local_8 = "sync";
                };
            };
            soundSampleCount = _local_9;
            soundFormat = 2;
            soundSize = 1;
            soundType = ((_local_5 == 3) ? 0 : 1);
            switch (_local_7)
            {
                case 44100:
                    soundRate = 3;
                    break;
                case 22050:
                    soundRate = 2;
                    break;
                case 11025:
                    soundRate = 1;
                    break;
                default:
                    throw (new Error((("Unsupported sampling rate: " + _local_7) + " Hz")));
            };
            soundData.length = 0;
            soundData.writeShort(0);
            soundData.writeBytes(_arg_1, _local_2, (_local_3 - _local_2));
        }


    }
}


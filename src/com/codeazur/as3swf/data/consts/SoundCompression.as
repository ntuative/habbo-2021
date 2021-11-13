package com.codeazur.as3swf.data.consts
{
    public class SoundCompression 
    {

        public static const _SafeStr_676:uint = 0;
        public static const ADPCM:uint = 1;
        public static const MP3:uint = 2;
        public static const _SafeStr_677:uint = 3;
        public static const NELLYMOSER_16_KHZ:uint = 4;
        public static const NELLYMOSER_8_KHZ:uint = 5;
        public static const NELLYMOSER:uint = 6;
        public static const _SafeStr_678:uint = 11;


        public static function toString(_arg_1:uint):String
        {
            switch (_arg_1)
            {
                case 0:
                    return ("Uncompressed Native Endian");
                case 1:
                    return ("ADPCM");
                case 2:
                    return ("MP3");
                case 3:
                    return ("Uncompressed Little Endian");
                case 4:
                    return ("Nellymoser 16kHz");
                case 5:
                    return ("Nellymoser 8kHz");
                case 6:
                    return ("Nellymoser");
                case 11:
                    return ("Speex");
                default:
                    return ("unknown");
            };
        }


    }
}


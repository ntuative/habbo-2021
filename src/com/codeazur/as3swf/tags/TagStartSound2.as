package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFSoundInfo;
    import com.codeazur.as3swf.SWFData;

    public class TagStartSound2 implements ITag 
    {

        public static const TYPE:uint = 89;

        public var soundClassName:String;
        public var soundInfo:SWFSoundInfo;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            soundClassName = _arg_1.readString();
            soundInfo = _arg_1.readSOUNDINFO();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeString(soundClassName);
            _local_3.writeSOUNDINFO(soundInfo);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (89);
        }

        public function get name():String
        {
            return ("StartSound2");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (2);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "SoundClassName: ") + soundClassName) + ", ") + "SoundInfo: ") + soundInfo);
        }


    }
}


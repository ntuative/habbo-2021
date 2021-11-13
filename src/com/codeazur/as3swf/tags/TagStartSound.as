package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFSoundInfo;
    import com.codeazur.as3swf.SWFData;

    public class TagStartSound implements ITag 
    {

        public static const TYPE:uint = 15;

        public var soundId:uint;
        public var soundInfo:SWFSoundInfo;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            soundId = _arg_1.readUI16();
            soundInfo = _arg_1.readSOUNDINFO();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(soundId);
            _local_3.writeSOUNDINFO(soundInfo);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (15);
        }

        public function get name():String
        {
            return ("StartSound");
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
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "SoundID: ") + soundId) + ", ") + "SoundInfo: ") + soundInfo);
        }


    }
}


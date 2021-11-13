package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;

    public class SWFSoundEnvelope 
    {

        public var pos44:uint;
        public var _SafeStr_375:uint;
        public var rightLevel:uint;

        public function SWFSoundEnvelope(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            pos44 = _arg_1.readUI32();
            _SafeStr_375 = _arg_1.readUI16();
            rightLevel = _arg_1.readUI16();
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeUI32(pos44);
            _arg_1.writeUI16(_SafeStr_375);
            _arg_1.writeUI16(rightLevel);
        }

        public function clone():SWFSoundEnvelope
        {
            var _local_1:SWFSoundEnvelope = new SWFSoundEnvelope();
            _local_1.pos44 = pos44;
            _local_1._SafeStr_375 = _SafeStr_375;
            _local_1.rightLevel = rightLevel;
            return (_local_1);
        }

        public function toString():String
        {
            return ("[SWFSoundEnvelope]");
        }


    }
}


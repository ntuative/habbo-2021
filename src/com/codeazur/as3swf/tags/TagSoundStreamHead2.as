package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.consts.SoundCompression;
    import com.codeazur.as3swf.data.consts._SafeStr_77;
    import com.codeazur.as3swf.data.consts._SafeStr_79;
    import com.codeazur.as3swf.data.consts._SafeStr_82;

    public class TagSoundStreamHead2 extends TagSoundStreamHead implements ITag 
    {

        public static const TYPE:uint = 45;


        override public function get type():uint
        {
            return (45);
        }

        override public function get name():String
        {
            return ("SoundStreamHead2");
        }

        override public function get version():uint
        {
            return (3);
        }

        override public function get level():uint
        {
            return (2);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
            if (_SafeStr_297 > 0)
            {
                _local_2 = (_local_2 + ((((((((((("Format: " + SoundCompression.toString(streamSoundCompression)) + ", ") + "Rate: ") + _SafeStr_77.toString(_SafeStr_274)) + ", ") + "Size: ") + _SafeStr_79.toString(_SafeStr_276)) + ", ") + "Type: ") + _SafeStr_82.toString(_SafeStr_277)) + ", "));
            };
            return (_local_2 + ("Samples: " + _SafeStr_297));
        }


    }
}


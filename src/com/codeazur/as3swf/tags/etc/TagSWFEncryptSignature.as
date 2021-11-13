package com.codeazur.as3swf.tags.etc
{
    import com.codeazur.as3swf.tags.TagUnknown;
    import com.codeazur.as3swf.tags.ITag;

    public class TagSWFEncryptSignature extends TagUnknown implements ITag 
    {

        public static const TYPE:uint = 0xFF;

        public function TagSWFEncryptSignature(_arg_1:uint=0)
        {
        }

        override public function get type():uint
        {
            return (0xFF);
        }

        override public function get name():String
        {
            return ("SWFEncryptSignature");
        }


    }
}
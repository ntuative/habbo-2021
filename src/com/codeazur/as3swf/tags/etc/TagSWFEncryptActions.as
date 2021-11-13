package com.codeazur.as3swf.tags.etc
{
    import com.codeazur.as3swf.tags.TagUnknown;
    import com.codeazur.as3swf.tags.ITag;

    public class TagSWFEncryptActions extends TagUnknown implements ITag 
    {

        public static const TYPE:uint = 253;

        public function TagSWFEncryptActions(_arg_1:uint=0)
        {
        }

        override public function get type():uint
        {
            return (253);
        }

        override public function get name():String
        {
            return ("SWFEncryptActions");
        }


    }
}
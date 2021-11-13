package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFTimelineContainer;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineSprite extends SWFTimelineContainer implements IDefinitionTag 
    {

        public static const TYPE:uint = 39;

        public var frameCount:uint;
        protected var _SafeStr_720:uint;


        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            frameCount = _arg_1.readUI16();
            parseTags(_arg_1, _arg_3);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeUI16(frameCount);
            publishTags(_local_3, _arg_2);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineSprite = new TagDefineSprite();
            throw (new Error("Not implemented yet."));
        }

        public function get type():uint
        {
            return (39);
        }

        public function get name():String
        {
            return ("DefineSprite");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "FrameCount: ") + frameCount) + super.toString(_arg_1));
        }


    }
}


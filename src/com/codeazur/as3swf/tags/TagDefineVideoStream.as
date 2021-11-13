package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.data.consts._SafeStr_90;
    import com.codeazur.as3swf.data.consts._SafeStr_96;

    public class TagDefineVideoStream implements IDefinitionTag 
    {

        public static const TYPE:uint = 60;

        public var _SafeStr_278:uint;
        public var width:uint;
        public var height:uint;
        public var _SafeStr_350:uint;
        public var smoothing:Boolean;
        public var _SafeStr_351:uint;
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
            _SafeStr_278 = _arg_1.readUI16();
            width = _arg_1.readUI16();
            height = _arg_1.readUI16();
            _arg_1.readUB(4);
            _SafeStr_350 = _arg_1.readUB(3);
            smoothing = (_arg_1.readUB(1) == 1);
            _SafeStr_351 = _arg_1.readUI8();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 10);
            _arg_1.writeUI16(characterId);
            _arg_1.writeUI16(_SafeStr_278);
            _arg_1.writeUI16(width);
            _arg_1.writeUI16(height);
            _arg_1.writeUB(4, 0);
            _arg_1.writeUB(3, _SafeStr_350);
            _arg_1.writeUB(1, ((smoothing) ? 1 : 0));
            _arg_1.writeUI8(_SafeStr_351);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineVideoStream = new TagDefineVideoStream();
            _local_1.characterId = characterId;
            _local_1._SafeStr_278 = _SafeStr_278;
            _local_1.width = width;
            _local_1.height = height;
            _local_1._SafeStr_350 = _SafeStr_350;
            _local_1.smoothing = smoothing;
            _local_1._SafeStr_351 = _SafeStr_351;
            return (_local_1);
        }

        public function get type():uint
        {
            return (60);
        }

        public function get name():String
        {
            return ("DefineVideoStream");
        }

        public function get version():uint
        {
            return (6);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Frames: ") + _SafeStr_278) + ", ") + "Width: ") + width) + ", ") + "Height: ") + height) + ", ") + "Deblocking: ") + _SafeStr_90.toString(_SafeStr_350)) + ", ") + "Smoothing: ") + smoothing) + ", ") + "Codec: ") + _SafeStr_96.toString(_SafeStr_351));
        }


    }
}


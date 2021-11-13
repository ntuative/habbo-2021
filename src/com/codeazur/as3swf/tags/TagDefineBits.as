package com.codeazur.as3swf.tags
{
    import flash.utils.ByteArray;
    import flash.display.Loader;
    import com.codeazur.as3swf.SWFData;
    import flash.display.BitmapData;
    import flash.events.Event;

    public class TagDefineBits implements IDefinitionTag 
    {

        public static const TYPE:uint = 6;

        public var _SafeStr_334:uint = 1;
        protected var _SafeStr_720:uint;
        protected var _bitmapData:ByteArray;
        protected var loader:Loader;
        protected var onCompleteCallback:Function;

        public function TagDefineBits()
        {
            _bitmapData = new ByteArray();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get bitmapData():ByteArray
        {
            return (_bitmapData);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            if (_arg_2 > 2)
            {
                _arg_1.readBytes(_bitmapData, 0, (_arg_2 - 2));
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, (_bitmapData.length + 2), true);
            _arg_1.writeUI16(_SafeStr_720);
            if (_bitmapData.length > 0)
            {
                _arg_1.writeBytes(_bitmapData);
            };
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineBits = new TagDefineBits();
            _local_1.characterId = characterId;
            _local_1._SafeStr_334 = _SafeStr_334;
            if (_bitmapData.length > 0)
            {
                _local_1.bitmapData.writeBytes(_bitmapData);
            };
            return (_local_1);
        }

        public function exportBitmapData(_arg_1:Function):void
        {
            onCompleteCallback = _arg_1;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener("complete", exportCompleteHandler);
            loader.loadBytes(_bitmapData);
        }

        protected function exportCompleteHandler(_arg_1:Event):void
        {
            var _local_2:Loader = (_arg_1.target.loader as Loader);
            var _local_3:BitmapData = new BitmapData(_local_2.content.width, _local_2.content.height);
            _local_3.draw(_local_2);
            onCompleteCallback(_local_3); //not popped
        }

        public function get type():uint
        {
            return (6);
        }

        public function get name():String
        {
            return ("DefineBits");
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
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "BitmapLength: ") + _bitmapData.length);
        }


    }
}


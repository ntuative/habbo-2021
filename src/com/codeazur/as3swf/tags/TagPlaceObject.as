package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFMatrix;
    import com.codeazur.as3swf.data.SWFColorTransform;
    import com.codeazur.as3swf.data.SWFClipActions;
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.filters.IFilter;
    import com.codeazur.as3swf.SWFData;

    public class TagPlaceObject implements _SafeStr_54 
    {

        public static const TYPE:uint = 4;

        public var hasClipActions:Boolean;
        public var hasClipDepth:Boolean;
        public var hasName:Boolean;
        public var hasRatio:Boolean;
        public var hasColorTransform:Boolean;
        public var hasMatrix:Boolean;
        public var hasCharacter:Boolean;
        public var hasMove:Boolean;
        public var hasBitmapBackgroundColor:Boolean;
        public var hasVisibility:Boolean;
        public var hasImage:Boolean;
        public var hasClassName:Boolean;
        public var hasCacheAsBitmap:Boolean;
        public var hasBlendMode:Boolean;
        public var hasFilterList:Boolean;
        public var characterId:uint;
        public var depth:uint;
        public var matrix:SWFMatrix;
        public var colorTransform:SWFColorTransform;
        public var _SafeStr_286:uint;
        public var instanceName:String;
        public var clipDepth:uint;
        public var _SafeStr_287:SWFClipActions;
        public var className:String;
        public var blendMode:uint;
        public var bitmapCache:uint;
        public var bitmapBackgroundColor:uint;
        public var visibility:uint;
        public var metaData:Object;
        protected var _SafeStr_739:Vector.<IFilter>;

        public function TagPlaceObject()
        {
            _SafeStr_739 = new Vector.<IFilter>();
        }

        public function get surfaceFilterList():Vector.<IFilter>
        {
            return (_SafeStr_739);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.position;
            characterId = _arg_1.readUI16();
            depth = _arg_1.readUI16();
            matrix = _arg_1.readMATRIX();
            hasCharacter = true;
            hasMatrix = true;
            if ((_arg_1.position - _local_5) < _arg_2)
            {
                colorTransform = _arg_1.readCXFORM();
                hasColorTransform = true;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeUI16(depth);
            _local_3.writeMATRIX(matrix);
            if (hasColorTransform)
            {
                _local_3.writeCXFORM(colorTransform);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (4);
        }

        public function get name():String
        {
            return ("PlaceObject");
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
            var _local_2:String = ((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Depth: ") + depth);
            if (hasCharacter)
            {
                _local_2 = (_local_2 + (", CharacterID: " + characterId));
            };
            if (hasMatrix)
            {
                _local_2 = (_local_2 + (", Matrix: " + matrix));
            };
            if (hasColorTransform)
            {
                _local_2 = (_local_2 + (", ColorTransform: " + colorTransform));
            };
            return (_local_2);
        }


    }
}


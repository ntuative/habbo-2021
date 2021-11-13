package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFShape;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.exporters.core.IShapeExporter;
    import com.codeazur.utils.StringUtils;

    public class TagDefineFont implements IDefinitionTag 
    {

        public static const TYPE:uint = 10;

        protected var _SafeStr_720:uint;
        protected var _SafeStr_725:Vector.<SWFShape>;

        public function TagDefineFont()
        {
            _SafeStr_725 = new Vector.<SWFShape>();
        }

        public function get characterId():uint
        {
            return (_SafeStr_720);
        }

        public function set characterId(_arg_1:uint):void
        {
            _SafeStr_720 = _arg_1;
        }

        public function get glyphShapeTable():Vector.<SWFShape>
        {
            return (_SafeStr_725);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_6:uint;
            _SafeStr_720 = _arg_1.readUI16();
            var _local_5:uint = (_arg_1.readUI16() >> 1);
            _arg_1.skipBytes(((_local_5 - 1) << 1));
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _SafeStr_725.push(_arg_1.readSHAPE(unitDivisor));
                _local_6++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_6:uint;
            var _local_7:SWFData = new SWFData();
            var _local_4:uint;
            var _local_5:uint = glyphShapeTable.length;
            var _local_3:SWFData = new SWFData();
            _local_7.writeUI16(characterId);
            var _local_8:uint = (_local_5 << 1);
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _local_7.writeUI16((_local_3.position + _local_8));
                _local_3.writeSHAPE(glyphShapeTable[_local_6]);
                _local_6++;
            };
            _local_7.writeBytes(_local_3);
            _arg_1.writeTagHeader(type, _local_7.length);
            _arg_1.writeBytes(_local_7);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineFont = new TagDefineFont();
            throw (new Error("Not implemented yet."));
        }

        public function export(_arg_1:IShapeExporter, _arg_2:uint):void
        {
            glyphShapeTable[_arg_2].export(_arg_1);
        }

        public function get type():uint
        {
            return (10);
        }

        public function get name():String
        {
            return ("DefineFont");
        }

        public function get version():uint
        {
            return (1);
        }

        public function get level():uint
        {
            return (1);
        }

        protected function get unitDivisor():Number
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Glyphs: ") + _SafeStr_725.length);
            return (_local_2 + toStringCommon(_arg_1));
        }

        protected function toStringCommon(_arg_1:uint):String
        {
            var _local_3:uint;
            var _local_2:String = "";
            _local_3 = 0;
            while (_local_3 < _SafeStr_725.length)
            {
                _local_2 = (_local_2 + (((("\n" + StringUtils.repeat((_arg_1 + 2))) + "[") + _local_3) + "] GlyphShapes:"));
                _local_2 = (_local_2 + _SafeStr_725[_local_3].toString((_arg_1 + 4)));
                _local_3++;
            };
            return (_local_2);
        }


    }
}


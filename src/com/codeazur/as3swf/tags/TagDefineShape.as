package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.data.SWFShapeWithStyle;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.as3swf.exporters.core.IShapeExporter;

    public class TagDefineShape implements IDefinitionTag 
    {

        public static const TYPE:uint = 2;

        public var shapeBounds:SWFRectangle;
        public var shapes:SWFShapeWithStyle;
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
            shapeBounds = _arg_1.readRECT();
            shapes = _arg_1.readSHAPEWITHSTYLE(level);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI16(characterId);
            _local_3.writeRECT(shapeBounds);
            _local_3.writeSHAPEWITHSTYLE(shapes, level);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function clone():IDefinitionTag
        {
            var _local_1:TagDefineShape = new TagDefineShape();
            throw (new Error("Not implemented yet."));
        }

        public function export(_arg_1:IShapeExporter=null):void
        {
            shapes.export(_arg_1);
        }

        public function get type():uint
        {
            return (2);
        }

        public function get name():String
        {
            return ("DefineShape");
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
            var _local_2:String = (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ") + "Bounds: ") + shapeBounds);
            return (_local_2 + shapes.toString((_arg_1 + 2)));
        }


    }
}


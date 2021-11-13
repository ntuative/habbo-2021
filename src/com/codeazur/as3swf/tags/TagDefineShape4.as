package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.data.SWFRectangle;
    import com.codeazur.as3swf.SWFData;

    public class TagDefineShape4 extends TagDefineShape3 implements IDefinitionTag 
    {

        public static const TYPE:uint = 83;

        public var _SafeStr_388:SWFRectangle;
        public var usesFillWindingRule:Boolean;
        public var usesNonScalingStrokes:Boolean;
        public var usesScalingStrokes:Boolean;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_720 = _arg_1.readUI16();
            shapeBounds = _arg_1.readRECT();
            _SafeStr_388 = _arg_1.readRECT();
            var _local_5:uint = _arg_1.readUI8();
            usesFillWindingRule = (!((_local_5 & 0x04) == 0));
            usesNonScalingStrokes = (!((_local_5 & 0x02) == 0));
            usesScalingStrokes = (!((_local_5 & 0x01) == 0));
            shapes = _arg_1.readSHAPEWITHSTYLE(level);
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:SWFData = new SWFData();
            _local_4.writeUI16(characterId);
            _local_4.writeRECT(shapeBounds);
            _local_4.writeRECT(_SafeStr_388);
            var _local_3:uint;
            if (usesFillWindingRule)
            {
                _local_3 = (_local_3 | 0x04);
            };
            if (usesNonScalingStrokes)
            {
                _local_3 = (_local_3 | 0x02);
            };
            if (usesScalingStrokes)
            {
                _local_3 = (_local_3 | 0x01);
            };
            _local_4.writeUI8(_local_3);
            _local_4.writeSHAPEWITHSTYLE(shapes, level);
            _arg_1.writeTagHeader(type, _local_4.length);
            _arg_1.writeBytes(_local_4);
        }

        override public function get type():uint
        {
            return (83);
        }

        override public function get name():String
        {
            return ("DefineShape4");
        }

        override public function get version():uint
        {
            return (8);
        }

        override public function get level():uint
        {
            return (4);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = (((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ID: ") + characterId) + ", ");
            if (usesFillWindingRule)
            {
                _local_2 = (_local_2 + "UsesFillWindingRule, ");
            };
            if (usesNonScalingStrokes)
            {
                _local_2 = (_local_2 + "UsesNonScalingStrokes, ");
            };
            if (usesScalingStrokes)
            {
                _local_2 = (_local_2 + "UsesScalingStrokes, ");
            };
            _local_2 = (_local_2 + ((("ShapeBounds: " + shapeBounds) + ", EdgeBounds: ") + _SafeStr_388));
            return (_local_2 + shapes.toString((_arg_1 + 2)));
        }


    }
}


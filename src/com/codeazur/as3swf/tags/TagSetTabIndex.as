package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagSetTabIndex implements ITag 
    {

        public static const TYPE:uint = 66;

        public var depth:uint;
        public var tabIndex:uint;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            depth = _arg_1.readUI16();
            tabIndex = _arg_1.readUI16();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 4);
            _arg_1.writeUI16(depth);
            _arg_1.writeUI16(tabIndex);
        }

        public function get type():uint
        {
            return (66);
        }

        public function get name():String
        {
            return ("SetTabIndex");
        }

        public function get version():uint
        {
            return (7);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "Depth: ") + depth) + ", ") + "TabIndex: ") + tabIndex);
        }


    }
}


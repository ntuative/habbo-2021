package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagProductInfo implements ITag 
    {

        public static const TYPE:uint = 41;
        private static const _SafeStr_740:Number = 4294967296;

        public var _SafeStr_342:uint;
        public var edition:uint;
        public var majorVersion:uint;
        public var minorVersion:uint;
        public var _SafeStr_343:Number;
        public var compileDate:Date;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            _SafeStr_342 = _arg_1.readUI32();
            edition = _arg_1.readUI32();
            majorVersion = _arg_1.readUI8();
            minorVersion = _arg_1.readUI8();
            _SafeStr_343 = (_arg_1.readUI32() + (_arg_1.readUI32() * 4294967296));
            var _local_5:Number = (_arg_1.readUI32() + (_arg_1.readUI32() * 4294967296));
            compileDate = new Date(_local_5);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeUI32(_SafeStr_342);
            _local_3.writeUI32(edition);
            _local_3.writeUI8(majorVersion);
            _local_3.writeUI8(minorVersion);
            _local_3.writeUI32(_SafeStr_343);
            _local_3.writeUI32((_SafeStr_343 / 4294967296));
            _local_3.writeUI32(compileDate.time);
            _local_3.writeUI32((compileDate.time / 4294967296));
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (41);
        }

        public function get name():String
        {
            return ("ProductInfo");
        }

        public function get version():uint
        {
            return (3);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return (((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "ProductID: ") + _SafeStr_342) + ", ") + "Edition: ") + edition) + ", ") + "Version: ") + majorVersion) + ".") + minorVersion) + " r") + _SafeStr_343) + ", ") + "CompileDate: ") + compileDate.toString());
        }


    }
}


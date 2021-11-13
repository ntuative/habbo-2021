package com.codeazur.as3swf.tags
{
    import __AS3__.vec.Vector;
    import com.codeazur.as3swf.data.SWFSymbol;
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagSymbolClass implements ITag 
    {

        public static const TYPE:uint = 76;

        protected var _symbols:Vector.<SWFSymbol>;

        public function TagSymbolClass()
        {
            _symbols = new Vector.<SWFSymbol>();
        }

        public function get symbols():Vector.<SWFSymbol>
        {
            return (_symbols);
        }

        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_6:uint;
            var _local_5:uint = _arg_1.readUI16();
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _symbols.push(_arg_1.readSYMBOL());
                _local_6++;
            };
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:uint;
            var _local_5:SWFData = new SWFData();
            var _local_3:uint = _symbols.length;
            _local_5.writeUI16(_local_3);
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5.writeSYMBOL(_symbols[_local_4]);
                _local_4++;
            };
            _arg_1.writeTagHeader(type, _local_5.length);
            _arg_1.writeBytes(_local_5);
        }

        public function get type():uint
        {
            return (76);
        }

        public function get name():String
        {
            return ("SymbolClass");
        }

        public function get version():uint
        {
            return (9);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            var _local_3:uint;
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
            if (_symbols.length > 0)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "Symbols:"));
                _local_3 = 0;
                while (_local_3 < _symbols.length)
                {
                    _local_2 = (_local_2 + ((((("\n" + StringUtils.repeat((_arg_1 + 4))) + "[") + _local_3) + "] ") + _symbols[_local_3].toString()));
                    _local_3++;
                };
            };
            return (_local_2);
        }


    }
}


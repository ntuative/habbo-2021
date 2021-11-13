package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagImportAssets2 extends TagImportAssets implements ITag 
    {

        public static const TYPE:uint = 71;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_6:uint;
            url = _arg_1.readString();
            _arg_1.readUI8();
            _arg_1.readUI8();
            var _local_5:uint = _arg_1.readUI16();
            _local_6 = 0;
            while (_local_6 < _local_5)
            {
                _symbols.push(_arg_1.readSYMBOL());
                _local_6++;
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_4:uint;
            var _local_5:SWFData = new SWFData();
            _local_5.writeString(url);
            _local_5.writeUI8(1);
            _local_5.writeUI8(0);
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

        override public function get type():uint
        {
            return (71);
        }

        override public function get name():String
        {
            return ("ImportAssets2");
        }

        override public function get version():uint
        {
            return (8);
        }

        override public function get level():uint
        {
            return (2);
        }


    }
}
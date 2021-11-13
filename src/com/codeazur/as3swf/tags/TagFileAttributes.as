package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagFileAttributes implements ITag 
    {

        public static const TYPE:uint = 69;

        public var useDirectBlit:Boolean = false;
        public var useGPU:Boolean = false;
        public var hasMetadata:Boolean = false;
        public var actionscript3:Boolean = true;
        public var useNetwork:Boolean = false;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            var _local_5:uint = _arg_1.readUI8();
            useDirectBlit = (!((_local_5 & 0x40) == 0));
            useGPU = (!((_local_5 & 0x20) == 0));
            hasMetadata = (!((_local_5 & 0x10) == 0));
            actionscript3 = (!((_local_5 & 0x08) == 0));
            useNetwork = (!((_local_5 & 0x01) == 0));
            _arg_1.skipBytes(3);
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            _arg_1.writeTagHeader(type, 4);
            var _local_3:uint;
            if (useNetwork)
            {
                _local_3 = (_local_3 | 0x01);
            };
            if (actionscript3)
            {
                _local_3 = (_local_3 | 0x08);
            };
            if (hasMetadata)
            {
                _local_3 = (_local_3 | 0x10);
            };
            if (useGPU)
            {
                _local_3 = (_local_3 | 0x20);
            };
            if (useDirectBlit)
            {
                _local_3 = (_local_3 | 0x40);
            };
            _arg_1.writeUI8(_local_3);
            _arg_1.writeUI8(0);
            _arg_1.writeUI8(0);
            _arg_1.writeUI8(0);
        }

        public function get type():uint
        {
            return (69);
        }

        public function get name():String
        {
            return ("FileAttributes");
        }

        public function get version():uint
        {
            return (8);
        }

        public function get level():uint
        {
            return (1);
        }

        public function toString(_arg_1:uint=0):String
        {
            return ((((((((((((((_SafeStr_64.toStringCommon(type, name, _arg_1) + "AS3: ") + actionscript3) + ", ") + "HasMetadata: ") + hasMetadata) + ", ") + "UseDirectBlit: ") + useDirectBlit) + ", ") + "UseGPU: ") + useGPU) + ", ") + "UseNetwork: ") + useNetwork);
        }


    }
}


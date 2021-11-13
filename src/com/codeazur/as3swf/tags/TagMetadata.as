package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;

    public class TagMetadata implements ITag 
    {

        public static const TYPE:uint = 77;

        public var xmlString:String;


        public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            xmlString = _arg_1.readString();
        }

        public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = new SWFData();
            _local_3.writeString(xmlString);
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        public function get type():uint
        {
            return (77);
        }

        public function get name():String
        {
            return ("Metadata");
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
            var _local_3:XML;
            var _local_2:String = _SafeStr_64.toStringCommon(type, name, _arg_1);
            try
            {
                _local_3 = new XML(xmlString);
                _local_2 = (_local_2 + (" " + _local_3.toXMLString()));
            }
            catch(error:Error)
            {
                _local_2 = (_local_2 + (" " + xmlString));
            };
            return (_local_2);
        }


    }
}


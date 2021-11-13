package com.codeazur.as3swf.tags
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class TagPlaceObject4 extends TagPlaceObject3 implements _SafeStr_54 
    {

        public static const TYPE:uint = 94;


        override public function parse(_arg_1:SWFData, _arg_2:uint, _arg_3:uint, _arg_4:Boolean=false):void
        {
            super.parse(_arg_1, _arg_2, _arg_3, _arg_4);
            if (_arg_1.bytesAvailable > 0)
            {
                metaData = _arg_1.readObject();
            };
        }

        override public function publish(_arg_1:SWFData, _arg_2:uint):void
        {
            var _local_3:SWFData = prepareBody();
            if (metaData != null)
            {
                _local_3.writeObject(metaData);
            };
            _arg_1.writeTagHeader(type, _local_3.length);
            _arg_1.writeBytes(_local_3);
        }

        override public function get type():uint
        {
            return (94);
        }

        override public function get name():String
        {
            return ("PlaceObject4");
        }

        override public function get version():uint
        {
            return (19);
        }

        override public function get level():uint
        {
            return (4);
        }

        override public function toString(_arg_1:uint=0):String
        {
            var _local_2:String = super.toString(_arg_1);
            if (metaData != null)
            {
                _local_2 = (_local_2 + (("\n" + StringUtils.repeat((_arg_1 + 2))) + "MetaData: yes"));
            };
            return (_local_2);
        }


    }
}


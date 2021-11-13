package com.sulake.habbo.friendbar.groupforums
{
    public class StringBuffer 
    {

        private static const GT_CHAR:Number = ">".charCodeAt(0);
        private static const LT_CHAR:Number = "<".charCodeAt(0);

        private var buffer:Array = [];


        public function addEscaped(_arg_1:String):StringBuffer
        {
            var _local_3:Number;
            var _local_2:Number;
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = _arg_1.charCodeAt(_local_3);
                switch (_local_2)
                {
                    case LT_CHAR:
                        add("&lt;");
                        break;
                    case GT_CHAR:
                        add("&gt;");
                        break;
                    default:
                        buffer.push(_local_2);
                };
                _local_3++;
            };
            return (this);
        }

        public function add(_arg_1:String):StringBuffer
        {
            var _local_2:Number;
            _local_2 = 0;
            while (_local_2 < _arg_1.length)
            {
                buffer.push(_arg_1.charCodeAt(_local_2));
                _local_2++;
            };
            return (this);
        }

        public function toString():String
        {
            return (String.fromCharCode.apply(this, buffer));
        }

        public function get length():int
        {
            return (buffer.length);
        }

        public function reset():void
        {
            buffer = [];
        }


    }
}
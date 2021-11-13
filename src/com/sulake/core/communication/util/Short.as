package com.sulake.core.communication.util
{
    import flash.utils.ByteArray;

    public class Short 
    {

        private var ba:ByteArray;

        public function Short(_arg_1:int)
        {
            ba = new ByteArray();
            ba.writeShort(_arg_1);
            ba.position = 0;
        }

        public function get value():int
        {
            var _local_1:int;
            ba.position = 0;
            if (ba.bytesAvailable)
            {
                _local_1 = ba.readShort();
                ba.position = 0;
            };
            return (_local_1);
        }


    }
}
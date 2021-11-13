package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class _SafeStr_66 implements IMessageParser 
    {

        protected var _SafeStr_2056:Vector.<FurniData>;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _SafeStr_2056 = new Vector.<FurniData>(0);
            var _local_2:int = 1;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _SafeStr_2056.push(new FurniData(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            _SafeStr_2056 = null;
            return (true);
        }

        public function getFurni():Vector.<FurniData>
        {
            return (_SafeStr_2056);
        }


    }
}


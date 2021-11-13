package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PickupObjectMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1922:int;
        private var _SafeStr_1924:int;

        public function PickupObjectMessageComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_1922 = _arg_1;
            _SafeStr_1924 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_1:int;
            switch (_SafeStr_1924)
            {
                case 10:
                    _local_1 = 2;
                    break;
                case 20:
                    _local_1 = 1;
                    break;
                default:
                    return ([]);
            };
            return ([_local_1, _SafeStr_1922]);
        }


    }
}


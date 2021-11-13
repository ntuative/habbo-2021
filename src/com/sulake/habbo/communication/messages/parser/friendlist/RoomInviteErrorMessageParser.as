package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomInviteErrorMessageParser implements IMessageParser 
    {

        private var _SafeStr_776:int;
        private var _SafeStr_1984:Array;


        public function flush():Boolean
        {
            this._SafeStr_1984 = [];
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            this._SafeStr_776 = _arg_1.readInteger();
            if (this._SafeStr_776 == 1)
            {
                _local_2 = _arg_1.readInteger();
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    this._SafeStr_1984.push(_arg_1.readInteger());
                    _local_3++;
                };
            };
            return (true);
        }

        public function get errorCode():int
        {
            return (this._SafeStr_776);
        }

        public function get failedRecipients():Array
        {
            return (this._SafeStr_1984);
        }


    }
}


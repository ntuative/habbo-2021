package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class CreateGuildMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array = [];

        public function CreateGuildMessageComposer(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Array)
        {
            var _local_7:int;
            super();
            _SafeStr_690.push(_arg_1);
            _SafeStr_690.push(_arg_2);
            _SafeStr_690.push(_arg_3);
            _SafeStr_690.push(_arg_4);
            _SafeStr_690.push(_arg_5);
            _SafeStr_690.push(_arg_6.length);
            _local_7 = 0;
            while (_local_7 < _arg_6.length)
            {
                _SafeStr_690.push(_arg_6[_local_7]);
                _local_7++;
            };
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
        }


    }
}


package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PollAnswerComposer implements IMessageComposer 
    {

        private var _SafeStr_690:Array;

        public function PollAnswerComposer(_arg_1:int, _arg_2:int, _arg_3:Array)
        {
            var _local_4:int;
            super();
            _SafeStr_690 = [_arg_1, _arg_2];
            _SafeStr_690.push(_arg_3.length);
            _local_4 = 0;
            while (_local_4 < _arg_3.length)
            {
                _SafeStr_690.push(_arg_3[_local_4]);
                _local_4++;
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


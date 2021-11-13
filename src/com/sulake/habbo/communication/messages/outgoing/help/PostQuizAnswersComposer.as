package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class PostQuizAnswersComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function PostQuizAnswersComposer(_arg_1:String, _arg_2:Array)
        {
            var _local_3:int;
            super();
            _SafeStr_875.push(_arg_1);
            _SafeStr_875.push(_arg_2.length);
            _local_3 = 0;
            while (_local_3 < _arg_2.length)
            {
                _SafeStr_875.push(_arg_2[_local_3]);
                _local_3++;
            };
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_875);
        }

        public function dispose():void
        {
            _SafeStr_875 = null;
        }


    }
}


package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetQuizQuestionsComposer implements IMessageComposer 
    {

        private var _SafeStr_875:Array = [];

        public function GetQuizQuestionsComposer(_arg_1:String)
        {
            _SafeStr_875.push(_arg_1);
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


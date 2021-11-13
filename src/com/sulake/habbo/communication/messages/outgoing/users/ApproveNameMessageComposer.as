package com.sulake.habbo.communication.messages.outgoing.users
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ApproveNameMessageComposer implements IMessageComposer 
    {

        private var _name:String;
        private var _SafeStr_741:int;

        public function ApproveNameMessageComposer(_arg_1:String, _arg_2:int)
        {
            _name = _arg_1;
            _SafeStr_741 = _arg_2;
        }

        public function getMessageArray():Array
        {
            return ([_name, _SafeStr_741]);
        }

        public function dispose():void
        {
        }


    }
}


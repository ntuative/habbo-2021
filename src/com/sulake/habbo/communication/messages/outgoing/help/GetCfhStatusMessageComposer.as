package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetCfhStatusMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1893:Boolean;

        public function GetCfhStatusMessageComposer(_arg_1:Boolean)
        {
            _SafeStr_1893 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1893]);
        }

        public function dispose():void
        {
        }


    }
}


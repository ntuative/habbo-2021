package com.sulake.habbo.communication.messages.outgoing.room.bots
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class GetBotCommandConfigurationDataComposer implements IMessageComposer 
    {

        private var _SafeStr_1917:int;
        private var _SafeStr_1918:int;

        public function GetBotCommandConfigurationDataComposer(_arg_1:int, _arg_2:int)
        {
            _SafeStr_1917 = _arg_1;
            _SafeStr_1918 = _arg_2;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1917, _SafeStr_1918]);
        }


    }
}


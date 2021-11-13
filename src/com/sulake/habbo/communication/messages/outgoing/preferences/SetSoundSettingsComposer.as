package com.sulake.habbo.communication.messages.outgoing.preferences
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class SetSoundSettingsComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_875:Array = [];

        public function SetSoundSettingsComposer(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _SafeStr_875.push(_arg_3);
            _SafeStr_875.push(_arg_2);
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

        public function get disposed():Boolean
        {
            return (false);
        }


    }
}


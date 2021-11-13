package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class ChangePostureMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1912:int;

        public function ChangePostureMessageComposer(_arg_1:int)
        {
            _SafeStr_1912 = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1912]);
        }

        public function dispose():void
        {
        }


    }
}


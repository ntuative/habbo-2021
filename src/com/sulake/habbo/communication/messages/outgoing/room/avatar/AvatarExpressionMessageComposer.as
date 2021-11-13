package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class AvatarExpressionMessageComposer implements IMessageComposer 
    {

        private var _SafeStr_1910:int = 0;

        public function AvatarExpressionMessageComposer(_arg_1:int)
        {
            _SafeStr_1910 = _arg_1;
        }

        public function dispose():void
        {
            _SafeStr_1910 = 0;
        }

        public function getMessageArray():Array
        {
            return ([_SafeStr_1910]);
        }


    }
}


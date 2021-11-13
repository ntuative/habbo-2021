package com.sulake.habbo.communication.messages.outgoing.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class AvatarEffectActivatedComposer implements IMessageComposer 
    {

        private var _SafeStr_741:int;

        public function AvatarEffectActivatedComposer(_arg_1:int)
        {
            _SafeStr_741 = _arg_1;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            var _local_1:Array = [];
            _local_1.push(_SafeStr_741);
            return (_local_1);
        }


    }
}


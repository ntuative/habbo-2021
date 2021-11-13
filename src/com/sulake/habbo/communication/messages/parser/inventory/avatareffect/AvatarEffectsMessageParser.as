package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvatarEffectsMessageParser implements IMessageParser 
    {

        private var _effects:Array;


        public function flush():Boolean
        {
            _effects = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:AvatarEffect;
            _effects = [];
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = new AvatarEffect();
                _local_2.type = _arg_1.readInteger();
                _local_2.subType = _arg_1.readInteger();
                _local_2.duration = _arg_1.readInteger();
                _local_2.inactiveEffectsInInventory = _arg_1.readInteger();
                _local_2.secondsLeftIfActive = _arg_1.readInteger();
                _local_2.isPermanent = _arg_1.readBoolean();
                _effects.push(_local_2);
                _local_4++;
            };
            return (true);
        }

        public function get effects():Array
        {
            return (_effects);
        }


    }
}
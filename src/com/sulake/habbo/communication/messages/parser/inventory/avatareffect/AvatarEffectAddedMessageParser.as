package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvatarEffectAddedMessageParser implements IMessageParser 
    {

        private var _type:int;
        private var _subType:int;
        private var _duration:int;
        private var _isPermanent:Boolean;


        public function flush():Boolean
        {
            _type = 0;
            _subType = 0;
            _duration = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _type = _arg_1.readInteger();
            _subType = _arg_1.readInteger();
            _duration = _arg_1.readInteger();
            _isPermanent = _arg_1.readBoolean();
            return (true);
        }

        public function get type():int
        {
            return (_type);
        }

        public function get subType():int
        {
            return (_subType);
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function get isPermanent():Boolean
        {
            return (_isPermanent);
        }


    }
}
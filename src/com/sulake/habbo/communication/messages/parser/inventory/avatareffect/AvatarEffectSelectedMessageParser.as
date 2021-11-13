package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvatarEffectSelectedMessageParser implements IMessageParser 
    {

        private var _type:int;


        public function flush():Boolean
        {
            _type = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _type = _arg_1.readInteger();
            return (true);
        }

        public function get type():int
        {
            return (_type);
        }


    }
}
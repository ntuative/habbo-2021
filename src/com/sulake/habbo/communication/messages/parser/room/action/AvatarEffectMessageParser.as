package com.sulake.habbo.communication.messages.parser.room.action
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AvatarEffectMessageParser implements IMessageParser 
    {

        private var _userId:int = 0;
        private var _effectId:int = 0;
        private var _delayMilliSeconds:int = 0;


        public function get userId():int
        {
            return (_userId);
        }

        public function get effectId():int
        {
            return (_effectId);
        }

        public function get delayMilliSeconds():int
        {
            return (_delayMilliSeconds);
        }

        public function flush():Boolean
        {
            _userId = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _userId = _arg_1.readInteger();
            _effectId = _arg_1.readInteger();
            _delayMilliSeconds = _arg_1.readInteger();
            return (true);
        }


    }
}
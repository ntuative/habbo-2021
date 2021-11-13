package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SpecialRoomEffectMessageParser implements IMessageParser 
    {

        private var _effectId:int = -1;


        public function flush():Boolean
        {
            _effectId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _effectId = _arg_1.readInteger();
            return (true);
        }

        public function get effectId():int
        {
            return (_effectId);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetPlacingErrorParser implements IMessageParser 
    {

        private var _errorCode:int;


        public function get errorCode():int
        {
            return (_errorCode);
        }

        public function flush():Boolean
        {
            _errorCode = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _errorCode = _arg_1.readInteger();
            return (true);
        }


    }
}
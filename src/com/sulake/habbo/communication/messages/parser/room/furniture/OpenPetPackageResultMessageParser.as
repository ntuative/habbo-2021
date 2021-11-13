package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class OpenPetPackageResultMessageParser implements IMessageParser 
    {

        private var _objectId:int = 0;
        private var _nameValidationStatus:int = 0;
        private var _nameValidationInfo:String = null;


        public function get objectId():int
        {
            return (_objectId);
        }

        public function get nameValidationStatus():int
        {
            return (_nameValidationStatus);
        }

        public function get nameValidationInfo():String
        {
            return (_nameValidationInfo);
        }

        public function flush():Boolean
        {
            _objectId = 0;
            _nameValidationStatus = 0;
            _nameValidationInfo = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _objectId = _arg_1.readInteger();
            _nameValidationStatus = _arg_1.readInteger();
            _nameValidationInfo = _arg_1.readString();
            return (true);
        }


    }
}
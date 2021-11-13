package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CanCreateRoomEventMessageParser implements IMessageParser 
    {

        private var _canCreateEvent:Boolean;
        private var _errorCode:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._canCreateEvent = _arg_1.readBoolean();
            this._errorCode = _arg_1.readInteger();
            return (true);
        }

        public function get canCreateEvent():Boolean
        {
            return (_canCreateEvent);
        }

        public function get errorCode():int
        {
            return (_errorCode);
        }


    }
}
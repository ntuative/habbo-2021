package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YouAreNotControllerMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;


        public function get flatId():int
        {
            return (_flatId);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            return (true);
        }


    }
}
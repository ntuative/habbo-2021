package com.sulake.habbo.communication.messages.parser.room.permissions
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class YouAreControllerMessageParser implements IMessageParser 
    {

        private var _flatId:int = 0;
        private var _roomControllerLevel:int = 0;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            this._flatId = _arg_1.readInteger();
            this._roomControllerLevel = _arg_1.readInteger();
            return (true);
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get roomControllerLevel():int
        {
            return (_roomControllerLevel);
        }


    }
}
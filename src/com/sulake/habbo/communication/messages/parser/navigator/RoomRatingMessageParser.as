package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RoomRatingMessageParser implements IMessageParser 
    {

        private var _rating:int;
        private var _canRate:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._rating = _arg_1.readInteger();
            this._canRate = _arg_1.readBoolean();
            return (true);
        }

        public function get rating():int
        {
            return (_rating);
        }

        public function get canRate():Boolean
        {
            return (_canRate);
        }


    }
}
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FavouriteChangedMessageParser implements IMessageParser 
    {

        private var _flatId:int;
        private var _added:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._flatId = _arg_1.readInteger();
            this._added = _arg_1.readBoolean();
            return (true);
        }

        public function get flatId():int
        {
            return (_flatId);
        }

        public function get added():Boolean
        {
            return (_added);
        }


    }
}
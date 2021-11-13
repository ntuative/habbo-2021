package com.sulake.habbo.communication.messages.incoming.hotlooks
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HotLookInfo 
    {

        private var _gender:String;
        private var _figureString:String;

        public function HotLookInfo(_arg_1:IMessageDataWrapper)
        {
            _gender = _arg_1.readString();
            _figureString = _arg_1.readString();
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get figureString():String
        {
            return (_figureString);
        }


    }
}
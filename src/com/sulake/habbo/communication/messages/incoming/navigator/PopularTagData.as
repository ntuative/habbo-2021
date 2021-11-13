package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PopularTagData 
    {

        private var _tagName:String;
        private var _userCount:int;

        public function PopularTagData(_arg_1:IMessageDataWrapper)
        {
            _tagName = _arg_1.readString();
            _userCount = _arg_1.readInteger();
        }

        public function get tagName():String
        {
            return (_tagName);
        }

        public function get userCount():int
        {
            return (_userCount);
        }


    }
}
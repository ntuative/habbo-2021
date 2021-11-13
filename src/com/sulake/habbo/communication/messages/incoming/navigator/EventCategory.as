package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class EventCategory 
    {

        private var _categoryId:int;
        private var _categoryName:String;
        private var _visible:Boolean;

        public function EventCategory(_arg_1:IMessageDataWrapper)
        {
            _categoryId = _arg_1.readInteger();
            _categoryName = _arg_1.readString();
            _visible = _arg_1.readBoolean();
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get categoryName():String
        {
            return (_categoryName);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }


    }
}
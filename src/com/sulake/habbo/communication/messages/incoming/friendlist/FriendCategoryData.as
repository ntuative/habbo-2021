package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FriendCategoryData 
    {

        private var _id:int;
        private var _name:String;

        public function FriendCategoryData(_arg_1:IMessageDataWrapper)
        {
            this._id = _arg_1.readInteger();
            this._name = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get name():String
        {
            return (_name);
        }


    }
}
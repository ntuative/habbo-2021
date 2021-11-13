package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class SavedSearch 
    {

        private var _id:int;
        private var _searchCode:String;
        private var _filter:String;
        private var _localization:String;

        public function SavedSearch(_arg_1:IMessageDataWrapper)
        {
            _id = _arg_1.readInteger();
            _searchCode = _arg_1.readString();
            _filter = _arg_1.readString();
            _localization = _arg_1.readString();
        }

        public function get id():int
        {
            return (_id);
        }

        public function get searchCode():String
        {
            return (_searchCode);
        }

        public function get filter():String
        {
            return (_filter);
        }

        public function get localization():String
        {
            return (_localization);
        }


    }
}
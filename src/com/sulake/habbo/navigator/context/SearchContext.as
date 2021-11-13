package com.sulake.habbo.navigator.context
{
    public class SearchContext 
    {

        private var _searchCode:String;
        private var _filtering:String;

        public function SearchContext(_arg_1:String, _arg_2:String)
        {
            this._searchCode = _arg_1;
            this._filtering = _arg_2;
        }

        public function get searchCode():String
        {
            return (_searchCode);
        }

        public function get filtering():String
        {
            return (_filtering);
        }

        public function toString():String
        {
            return ((_searchCode + " : ") + _filtering);
        }


    }
}